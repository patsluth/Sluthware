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
	
	public func sorted<Value>(by keyPath: KeyPath<Element, Value>,
							  _ comparator: (Value, Value) -> Bool) -> [Element]
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



// TODO: Move somewhere else
public extension Dictionary
	where Key: Comparable
{
	public func sorted(by keyComparator: (Key, Key) -> Bool,
					   _ valueTransformer: (Value) -> Value) -> [(key: Key, value: Value)]
	{
		return self.sorted(by: {
			keyComparator($0.key, $1.key)
		}).map({
			(key: $0.key, value: valueTransformer($0.value))
		})
		
		//		return self.reduce(into: [(key: Key, value: Value)](), {
		////			let key = $1[keyPath: keyPath]
		////			var elements = $0[key, default: []]
		////			elements.append($1)
		////			$0[key] = elements
		//		})
	}
}

//public extension Dictionary
//	where Key: Comparable,
//	Value: AnyCollection
//{
//	public func sorted5(by comparator: (Key, Key) -> Bool) -> [(key: Key, value: Value)]
//	{
//		return []
//	}
//}




