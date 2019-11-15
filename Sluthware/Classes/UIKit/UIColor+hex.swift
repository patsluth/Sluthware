//
//  UIColor+hex.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-07-25.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension UIColor
{
    @objc convenience init?(hex: String!)
	{
		guard var hex = hex else { return nil }
		
		if hex.prefix(1) == "#" {
			hex.removeFirst(1)
		}
		if hex.prefix(2).lowercased() == "0x" {
			hex.removeFirst(2)
		}
		if hex.count == 6 {
			hex.append("FF")
		}
		
		let hexValue: UInt64 = {
			var hexValue: UInt64 = 0
			let scanner = Scanner(string: hex)
			scanner.scanLocation = 0
			scanner.scanHexInt64(&hexValue)
			return hexValue
		}()
		
		if hex.count == 8 {
			let r = CGFloat((hexValue & 0xFF000000) >> 24) / 0xFF
			let g = CGFloat((hexValue & 0x00FF0000) >> 16) / 0xFF
			let b = CGFloat((hexValue & 0x0000FF00) >> 08) / 0xFF
			let a = CGFloat((hexValue & 0x000000FF) >> 00) / 0xFF
			
			self.init(red: r, green: g, blue: b, alpha: a)
		} else {
			return nil
		}
	}
	
    @objc func toHex() -> String
	{
		var r: CGFloat = 0.0
		var g: CGFloat = 0.0
		var b: CGFloat = 0.0
		var a: CGFloat = 0.0
		
		self.getRed(&r, green: &g, blue: &b, alpha: &a)
		
		return String(format: "0x%02X%02X%02X%02X",
					  UInt8(r * 0xFF),
					  UInt8(g * 0xFF),
					  UInt8(b * 0xFF),
					  UInt8(a * 0xFF))
	}
}




