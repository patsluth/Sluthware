//
//  UIViewController+Top.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-03.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension UIViewController
{
	var topmost: UIViewController? {
		var top = UIApplication.shared.keyWindow?.rootViewController
		while let presented = top?.presentedViewController {
			top = presented
		}
		return top
	}
	
	var topmostOrSelf: UIViewController {
		return self.topmost ?? self
	}
}




