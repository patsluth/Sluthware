//
//  KeyedDecodingContainer+fallback.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public extension KeyedDecodingContainer
{
	func decode<T>(_ type: T.Type,
				   forKeys key: Key,
				   _ fallbackKeys: Key...) throws -> T
		where T: Decodable
	{
		return try self.decode(type, forKeys: key, fallbackKeys)
	}
	
	func decode<T>(_ type: T.Type,
				   forKeys key: Key,
				   _ fallbackKeys: [Key]) throws -> T
		where T: Decodable
	{
		var fallback = fallbackKeys
		
		do {
			return try self.decode(type, forKey: key)
		} catch {
			if let nextKey = fallback.popFirst() {
				return try self.decode(type, forKeys: nextKey, fallback)
			} else {
				throw error
			}
		}
	}
	
	func decodeIfPresent<T>(_ type: T.Type,
							forKeys key: Key,
							_ fallbackKeys: Key...) throws -> T?
		where T: Decodable
	{
		return try self.decodeIfPresent(type, forKeys: key, fallbackKeys)
	}
	
	func decodeIfPresent<T>(_ type: T.Type,
							forKeys key: Key,
							_ fallbackKeys: [Key]) throws -> T?
		where T: Decodable
	{
		var fallback = fallbackKeys
		
		do {
			if let value = try self.decodeIfPresent(type, forKey: key) {
				return value
			} else if let nextKey = fallback.popFirst() {
				return try self.decodeIfPresent(type, forKeys: nextKey, fallback)
			}
		} catch {
			if let nextKey = fallback.popFirst() {
				return try self.decodeIfPresent(type, forKeys: nextKey, fallback)
			} else {
				throw error
			}
		}
		
		return nil
	}
}




