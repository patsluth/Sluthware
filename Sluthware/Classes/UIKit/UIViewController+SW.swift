//
//  UIViewController+SW.swift
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
		self.willMove(toParent: vc)
		vc.addChild(self)
		if let stackView = superview as? UIStackView {
			stackView.add(self.view)
		} else {
			superview.addSubview(self.view)
		}
		self.didMove(toParent: vc)
		
		return self
	}
}




