//
//  UIView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-03.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension NSObjectProtocol
	where Self: UIView
{
	@discardableResult
	func superview(_ superview: UIView) -> Self
	{
		superview.addSubview(self)
		
		return self
	}
}




