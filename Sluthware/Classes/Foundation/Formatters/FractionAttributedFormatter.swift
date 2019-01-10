//
//  FractionAttributedFormatter.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public final class FractionAttributedFormatter: AttributedFormatterProtocol
{
	public typealias Value = Fraction
	
	
	
	
	
	public var font = Font.systemFont(ofSize: Font.systemFontSize)
	public var useProperFractions = true
//	public var useProperFractions = true
	
	
	
	
	
	public init()
	{
	}
	
	public func format(_ value: Fraction) -> NSAttributedString
	{
		var attributedString = NSAttributedString()

		switch (value.doubleValue, self.useProperFractions) {
		case (let x, _) where x.isNaN:
			attributedString = NSAttributedString("NaN", {
				$0[NSAttributedString.Key.font] = self.font
			})
		case (let x, _) where x.isInfinite:
			attributedString = NSAttributedString("∞", {
				$0[NSAttributedString.Key.font] = self.font
			})
		case (let x, _) where x.isZero:
			attributedString = NSAttributedString("0", {
				$0[NSAttributedString.Key.font] = self.font
			})
		// Proper Fraction
		case (let x, _) where fabs(x).isLess(than: 1.0):
			attributedString = NSAttributedString("\(value)", {
				$0[NSAttributedString.Key.font] = self.font.forFraction()
			})
		// Improper Fraction
		case (_, false):
			attributedString = NSAttributedString("\(value)", {
				$0[NSAttributedString.Key.font] = self.font.forFraction()
			})
		// Improper Fraction
		case (_, true):
			let mixedNumber = value.asMixedNumber()
			
			if mixedNumber.fraction.num != 0 {
				attributedString = self.format(mixedNumber.fraction)
			}
			
			if mixedNumber.whole != 0 {
				attributedString = NSAttributedString("\(mixedNumber.whole)", {
					$0[NSAttributedString.Key.font] = self.font
				}) +
				attributedString
			}
		}

		return attributedString
	}
}




