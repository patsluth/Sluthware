//
//  UIColor+systemTintColor.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-11-02.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension UIColor
{
	public static var systemTintColor: UIColor {
		return UIButton(type: .system).tintColor
	}
}




