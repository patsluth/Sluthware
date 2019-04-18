//
// 	UIViewControllersSettable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-01-05.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation
import UIKit





public extension NSObjectProtocol
	where Self == UINavigationController
{
	@discardableResult
	func set(viewControllers: [UIViewController], animated: Bool = false) -> Self
	{
		self.setViewControllers(viewControllers, animated: animated)
		return self
	}
}





public extension NSObjectProtocol
	where Self == UITabBarController
{
	@discardableResult
	func set(viewControllers: [UIViewController], animated: Bool = false) -> Self
	{
		self.setViewControllers(viewControllers, animated: animated)
		return self
	}
}




