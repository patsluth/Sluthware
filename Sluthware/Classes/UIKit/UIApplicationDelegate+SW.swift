//
//  UIApplicationDelegate+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-01-05.
//  Copyright © 2018 patsluth. All rights reserved.
//

import UIKit





public extension UIApplicationDelegate
{
	static var shared: Self! {
		return UIApplication.shared.delegate as? Self
	}
}




