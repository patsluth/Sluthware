//
//  UITintedLabel.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//





public class UITintedLabel: UILabel
{
	override public func tintColorDidChange()
	{
		super.tintColorDidChange()
		
		self.textColor = self.tintColor
	}
}




