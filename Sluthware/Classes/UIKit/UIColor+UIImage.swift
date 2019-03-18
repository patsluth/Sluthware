//
//  UIColor+UIImage.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-02.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension UIColor
{
	var uiImage: UIImage? {
		let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
		UIGraphicsBeginImageContext(rect.size)
		defer {
			UIGraphicsEndImageContext()
		}
		
		let context = UIGraphicsGetCurrentContext()
		context?.setFillColor(self.cgColor)
		context?.fill(rect)
		
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}




