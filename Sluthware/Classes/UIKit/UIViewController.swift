//
//  UIViewController.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-03.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension NSObjectProtocol
	where Self: UIViewController
{
	@discardableResult
	func embedIn(parent vc: UIViewController, superview: UIView) -> Self
	{
		self.willMove(toParent: self)
		vc.addChild(self)
		superview.addSubview(self.view)
		self.didMove(toParent: self)
		
		return self
	}
}




