//
//  UINavigationBar+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-01-05.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation
import UIKit





public extension UINavigationBar
{
	@available(iOS 11.0, *)
	var contentView: UIView? {
		for subview in self.subviews {
			if NSClassFromString("_UINavigationBarContentView") === type(of: subview) {
				return subview
			}
		}
		
		return nil
	}
	
	@available(iOS 11.0, *)
	var largeTitleView: UIView? {
		for subview in self.subviews {
			if NSClassFromString("_UINavigationBarLargeTitleView") === type(of: subview) {
				return subview
			}
		}
		
		return nil
	}
}




