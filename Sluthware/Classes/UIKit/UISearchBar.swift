//
//  UIHierarchy.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit





public extension UISearchBar
{
	public var textField: UITextField! {
		return self.value(forKey: "searchField") as? UITextField
	}
}




