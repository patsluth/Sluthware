//
//  UIColor.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-11-02.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension UIColor
{
	public func with(alpha: CGFloat) -> UIColor
	{
		return self.withAlphaComponent(alpha)
	}
	
	public func lighter(by percentage: CGFloat) -> UIColor
	{
		return self.adjusting(by: abs(percentage))
	}
	
	public func darker(by percentage: CGFloat) -> UIColor
	{
		return self.adjusting(by: abs(percentage) * -1.0)
	}
	
	/**
	-ve percentage = darker
	+ve percentage = lighter
	*/
	public func adjusting(by percentage: CGFloat) -> UIColor
	{
		guard var rgba = try? self.getRGBA() else { return self }
		let percentage = (-1.0...1.0).clamp(percentage)
		
		rgba.r += (rgba.r * percentage)
		rgba.g += (rgba.g * percentage)
		rgba.b += (rgba.b * percentage)
		
		return rgba.uiColor
	}
	
	
	
	public func brighter(by percentage: CGFloat) -> UIColor
	{
		return self.adjustingBrightness(by: abs(percentage))
	}
	
	public func dimmmer(by percentage: CGFloat) -> UIColor
	{
		return self.adjustingBrightness(by: abs(percentage) * -1.0)
	}
	
	/**
	-ve percentage = brighter
	+ve percentage = dimmmer
	*/
	public func adjustingBrightness(by percentage: CGFloat) -> UIColor
	{
		guard var hsba = try? self.getHSBA() else { return self }
		let percentage = (-1.0...1.0).clamp(percentage)
		
		switch hsba.b {
		case 0.0:
			hsba.b += (percentage)
		case 1.0:
			hsba.b += (hsba.b * percentage)
		default:
			hsba.s -= (hsba.s * percentage)
		}
		
		return hsba.uiColor
	}
	
	
	
	/// Calculates a nice constrasting color (good for selecting a text color that looks good over a background color)
	/// Converted from https://stackoverflow.com/questions/28644311/how-to-get-the-rgb-code-int-from-an-uicolor-in-swift
	public func contrastingColor(fallback: UIColor) -> UIColor
	{
		guard let rgba = try? self.getRGBA() else { return fallback }
		
		// Counting the perceptive luminance - human eye favors green color...
		let a = 1.0 - (0.299 * rgba.r + 0.587 * rgba.g + 0.114 * rgba.b)
		
		if a < 0.5 {    // bright colors - black font
			return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
		} else {        // dark colors - white font
			return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}
}




