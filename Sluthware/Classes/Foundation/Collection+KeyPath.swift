//
//  Collection+KeyPath.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Collection
	where Self: ExpressibleByArrayLiteral, Element: AnyObject
{
	public func grouped<Value>(by keyPath: KeyPath<Element, Value>) -> [Value: [Element]]
		where Value: Hashable
	{
		return self.reduce(into: [Value: [Element]](), {
			let key = $1[keyPath: keyPath]
			var elements = $0[key, default: []]
			elements.append($1)
			$0[key] = elements
		})
	}
	
	public func sorted<Value>(by keyPath: KeyPath<Element, Value>, _ comparator: (Value, Value) -> Bool) -> [Element]
		where Value: Comparable
	{
		return self.sorted(by: {
			comparator($0[keyPath: keyPath], $1[keyPath: keyPath])
		})
	}
	
	//	public mutating func sort<Value>(by keyPath: KeyPath<Element, Value>, _ comparator: (Value, Value) -> Bool)
	//	{
	//		self = self.sorted(by: keyPath, comparator)
	//	}
}




