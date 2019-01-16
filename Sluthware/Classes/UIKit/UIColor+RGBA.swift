//
//  UIColor+RGBA.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-11-02.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension UIColor
{
	/**
	Red, Green, Blue, Alpha
	*/
	public struct RGBA: Codable, ReflectedStringConvertible
	{
		var r: CGFloat
		var g: CGFloat
		var b: CGFloat
		var a: CGFloat
		
		public var uiColor: UIColor {
			return UIColor(red: 	(0.0...1.0).clamp(self.r),
						   green: 	(0.0...1.0).clamp(self.g),
						   blue: 	(0.0...1.0).clamp(self.b),
						   alpha:	(0.0...1.0).clamp(self.a))
		}
	}
	
	
	
	
	
	public func getRGBA() throws -> RGBA
	{
		var rgba = RGBA(r: 0.0, g: 0.0, b: 0.0, a: 0.0)
		
		if !self.getRed(&rgba.r, green: &rgba.g, blue: &rgba.b, alpha: &rgba.a) {
			throw Errors.Message("\(#function) failed")
		}
		
		return rgba
	}
}





