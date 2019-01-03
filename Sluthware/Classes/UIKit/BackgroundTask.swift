//
//  BackgroundTask.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-01-05.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation





public final class BackgroundTask
{
	let name: String
	fileprivate var taskIdentifier = UIBackgroundTaskIdentifier.invalid
	
	
	
	
	
	@discardableResult
	public init(name: String, _ start: (_ stop: @escaping () -> Void) -> Void) throws
	{
		self.name = name
		self.taskIdentifier = UIApplication.shared
			.beginBackgroundTask(withName: self.name, expirationHandler: { [weak self] in
				guard let `self` = self else { return }
				self.stop()
			})
		
		guard self.taskIdentifier != UIBackgroundTaskIdentifier.invalid else {
			throw Errors.Message("Failed to start \(#file.fileName) named \(self.name)")
		}
		
		ProcessInfo.processInfo.performExpiringActivity(withReason: name, using: { [weak self] expired in
			if (!expired) {
				while let `self` = self {
					guard self.taskIdentifier != UIBackgroundTaskIdentifier.invalid else { break }
				}
			} else {	// Abort and cleanup quickly
				self?.stop()
			}
			// once block returns the task assertion is released
		})
		
		print("Starting \(#file.fileName) named \(self.name)")
		
		start({
			self.stop()
		})
	}
	
	deinit
	{
		self.stop()
	}
	
	fileprivate func stop()
	{
		guard self.taskIdentifier != UIBackgroundTaskIdentifier.invalid else { return }
		
		print("Stopping \(#file.fileName) named \(self.name)")
		
		UIApplication.shared.endBackgroundTask(self.taskIdentifier)
		self.taskIdentifier = UIBackgroundTaskIdentifier.invalid
	}
}



