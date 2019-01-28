//
//  MixedNumberFormatter.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public final class MixedNumberFormatter: AttributedFormatterProtocol
{
	public typealias Value = Fraction.MixedNumber
	
	
	
	
	
	public var font = Font.systemFont(ofSize: Font.systemFontSize)
	
	
	
	
	
	public init()
	{
	}
	
	public func format(_ value: Value) -> NSAttributedString
	{
		let fractionFormatter = FractionFormatter({
			$0.font = self.font
		})
		
		var attributedString = NSAttributedString()
		
		if value.fraction.num != 0 {
			attributedString = fractionFormatter.format(value.fraction)
		}
		
		if value.whole != 0 {
			attributedString = NSAttributedString("\(value.whole)", {
				$0[NSAttributedString.Key.font] = self.font
			}) + attributedString
		}
		
		return attributedString
	}
}




