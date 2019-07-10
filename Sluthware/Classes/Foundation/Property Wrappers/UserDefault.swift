//
//  UserDefault.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





@propertyWrapper
public struct UserDefault<T>
{
	public let key: String
	public let defaultValue: T
	public let userDefaults: UserDefaults
	
	public var value: T {
		get
		{
			return self.userDefaults.object(forKey: key) as? T ?? defaultValue
		}
		set
		{
			self.userDefaults.set(newValue, forKey: self.key)
		}
	}
	
	
	
	
	
	init(_ key: String,
		 _ defaultValue: T,
		 _ userDefaults: UserDefaults = UserDefaults.standard)
	{
		self.key = key
		self.defaultValue = defaultValue
		self.userDefaults = userDefaults
	}
}




