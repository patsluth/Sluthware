//
//  UIApplication+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import UIKit
import UserNotifications





public extension UIApplication
{
    static var sharedSafe: UIApplication? {
		let sharedSelector = NSSelectorFromString("shared")
		guard UIApplication.responds(to: sharedSelector) else { return nil }
		let shared = UIApplication.perform(sharedSelector)
		let application = shared?.takeUnretainedValue() as? UIApplication
		return application
	}
	
	
	
	
	
	@available(iOS 10.0, *)
	func authorizeUserNotifications(options: UNAuthorizationOptions,
									_ completion: @escaping (UNAuthorizationStatus) -> Void)
	{
		let nc = UNUserNotificationCenter.current()
		
		nc.getNotificationSettings { settings in
			switch settings.authorizationStatus {
			case .notDetermined:
				nc.requestAuthorization(options: options) { status, error in
					if let result = Result(status, error) {
						sw.log(result)
					}
					self.authorizeUserNotifications(options: options, completion)
				}
			default:
				completion(settings.authorizationStatus)
			}
		}
	}
}




