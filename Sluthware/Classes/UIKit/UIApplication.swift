//
//  UIApplication.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import UIKit





public extension UIApplication
{
	public static var sharedSafe: UIApplication? {
		let sharedSelector = NSSelectorFromString("shared")
		guard UIApplication.responds(to: sharedSelector) else { return nil }
		let shared = UIApplication.perform(sharedSelector)
		let application = shared?.takeUnretainedValue() as? UIApplication
		return application
	}
}




