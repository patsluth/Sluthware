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
	public typealias Handler = (() -> Void) -> Void
	
	
	
	
	
	public let name: String
	private var taskIdentifier = UIBackgroundTaskIdentifier.invalid
	
	
	
	
	
	@discardableResult
	public init(name: String = "\(#file.fileName).\(#function)",
		_ handler: @escaping BackgroundTask.Handler)// throws
	{
		self.name = name
		
		self.taskIdentifier = UIApplication.shared
			.beginBackgroundTask(withName: self.name, expirationHandler: { [weak self] in
				guard let `self` = self else { return }
				self.stop()
			})
		
		//		guard self.taskIdentifier != UIBackgroundTaskIdentifier.invalid else {
		//			throw Errors.Message("Failed to start \(#file.fileName) named \(self.name)")
		//		}
		
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
		
		print("Starting \(type(of: self)) named \(self.name)")
		
		handler({ [weak self] in
			self?.stop()
		})
	}
	
	deinit
	{
		self.stop()
	}
	
	fileprivate func stop()
	{
		guard self.taskIdentifier != UIBackgroundTaskIdentifier.invalid else { return }
		
		print("Stopping \(type(of: self)) named \(self.name)")
		
		UIApplication.shared.endBackgroundTask(self.taskIdentifier)
		self.taskIdentifier = UIBackgroundTaskIdentifier.invalid
	}
}



