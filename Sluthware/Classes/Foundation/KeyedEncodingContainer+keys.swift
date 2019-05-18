//
//  KeyedEncodingContainer+keys.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public extension KeyedEncodingContainer
{
	mutating func encode<T>(_ value: T, forKeys keys: Key...) throws
		where T: Encodable
	{
		self.encode(value: forKeys: keys)
	}
	
	mutating func encode<T>(_ value: T, forKeys keys: [Key]) throws
		where T: Encodable
	{
		for key in keys {
			try self.encode(value, forKey: key)
		}
	}
	
	mutating func encodeConditional<T>(_ object: T, forKeys keys: Key...) throws
		where T: AnyObject, T: Encodable
	{
		self.encodeConditional(value: forKeys: keys)
	}
	
	mutating func encodeConditional<T>(_ object: T, forKeys keys: [Key]) throws
		where T: AnyObject, T: Encodable
	{
		for key in keys {
			try self.encodeConditional(object, forKey: key)
		}
	}
	
	mutating func encodeIfPresent<T>(_ value: T, forKeys keys: Key...) throws
		where T: AnyObject, T: Encodable
	{
		self.encodeIfPresent(value: forKeys: keys)
	}
	
	mutating func encodeIfPresent<T>(_ value: T, forKeys keys: [Key]) throws
		where T: AnyObject, T: Encodable
	{
		for key in keys {
			try self.encodeIfPresent(value, forKey: key)
		}
	}
}




