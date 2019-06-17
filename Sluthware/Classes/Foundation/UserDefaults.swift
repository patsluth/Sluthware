//
//  UserDefaults.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-03-20.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation





public extension UserDefaults
{
	subscript<T>(_ type: T.Type, _ key: String) -> T?
	{
		get
		{
			return self.value(forKey: key) as? T
		}
		set
		{
			self.setValue(newValue, forKey: key)
		}
	}
}




