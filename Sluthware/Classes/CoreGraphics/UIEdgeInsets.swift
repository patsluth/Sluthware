//
//  UIEdgeInsets.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension UIEdgeInsets
{
	var size: CGSize {
		return CGSize(width: self.left + self.right,
					  height: self.top + self.bottom)
	}
	
	
	
	
	
	init(_ spacing: (h: CGFloat, v: CGFloat))
	{
		self = UIEdgeInsets(spacing.h, spacing.v)
	}
	
	init(_ horizontal: CGFloat, _ vertical: CGFloat)
	{
		self = UIEdgeInsets(top: vertical,
							left: horizontal,
							bottom: vertical,
							right: horizontal)
	}
	
	@discardableResult
	mutating func top(_ value: CGFloat) -> UIEdgeInsets
	{
		self.top = value
		return self
	}
	
	@discardableResult
	mutating func left(_ value: CGFloat) -> UIEdgeInsets
	{
		self.left = value
		return self
	}
	
	@discardableResult
	mutating func bottom(_ value: CGFloat) -> UIEdgeInsets
	{
		self.bottom = value
		return self
	}
	
	@discardableResult
	mutating func right(_ value: CGFloat) -> UIEdgeInsets
	{
		self.right = value
		return self
	}
}




