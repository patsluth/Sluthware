//
//  Codable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import CoreGraphics





public extension CGSize
{
	var integral: CGSize {
		return CGSize(width: Int(self.width), height: Int(self.height))
	}
	
	
	
	
	
	static func +(lhs: CGSize, rhs: CGSize) -> CGSize
	{
		return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
	}
	
	static func +=(lhs: inout CGSize, rhs: CGSize)
	{
		lhs = lhs + rhs
	}
	
	static func +(lhs: CGSize, rhs: CGFloat) -> CGSize
	{
		return CGSize(width: lhs.width + rhs, height: lhs.height + rhs)
	}
	
	static func +=(lhs: inout CGSize, rhs: CGFloat)
	{
		lhs = lhs + rhs
	}
	
	
	
	static func -(lhs: CGSize, rhs: CGSize) -> CGSize
	{
		return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
	}
	
	static func -=(lhs: inout CGSize, rhs: CGSize)
	{
		lhs = lhs - rhs
	}
	
	static func -(lhs: CGSize, rhs: CGFloat) -> CGSize
	{
		return CGSize(width: lhs.width - rhs, height: lhs.height - rhs)
	}
	
	static func -=(lhs: inout CGSize, rhs: CGFloat)
	{
		lhs = lhs - rhs
	}
	
	
	
	static func *(lhs: CGSize, rhs: CGSize) -> CGSize
	{
		return CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
	}
	
	static func *=(lhs: inout CGSize, rhs: CGSize)
	{
		lhs = lhs * rhs
	}
	
	static func *(lhs: CGSize, rhs: CGFloat) -> CGSize
	{
		return CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
	}
	
	static func *=(lhs: inout CGSize, rhs: CGFloat)
	{
		lhs = lhs * rhs
	}
	
	
	
	static func /(lhs: CGSize, rhs: CGSize) -> CGSize
	{
		return CGSize(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
	}
	
	static func /=(lhs: inout CGSize, rhs: CGSize)
	{
		lhs = lhs / rhs
	}
	
	static func /(lhs: CGSize, rhs: CGFloat) -> CGSize
	{
		return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
	}
	
	static func /=(lhs: inout CGSize, rhs: CGFloat)
	{
		lhs = lhs / rhs
	}
}





public extension CGSize
{
	/// Returns new CGSize with width
	func with(width: CGFloat) -> CGSize
	{
		var size = self
		return size.width(width)
	}
	
	/// Returns new CGSize with height
	func with(height: CGFloat) -> CGSize
	{
		var size = self
		return size.height(height)
	}
	
	/// Returns update CGSize with width
	@discardableResult
	mutating func width(_ width: CGFloat) -> CGSize
	{
		self.width = width
		return self
	}
	
	/// Returns update CGSize with width
	@discardableResult
	mutating func height(_ height: CGFloat) -> CGSize
	{
		self.height = height
		return self
	}
}




