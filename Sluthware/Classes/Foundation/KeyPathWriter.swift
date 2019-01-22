//
//  KeyPathWriter.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public class KeyPathWriter<Root, Value>
{
	public let keyPath: WritableKeyPath<Root, Value>
	
	public init(_ keyPath: WritableKeyPath<Root, Value>)
	{
		self.keyPath = keyPath
	}
	
	public func write(value: Value, toObject root: inout Root)
	{
		root[keyPath: self.keyPath] = value
	}
}





final public class SafeKeyPathWriter<Root, Value>: KeyPathWriter<Root, Value>
{
	private let ifKeyPath: PartialKeyPath<Root>
	
	public init<V>(_ ifKeyPath: KeyPath<Root, V?>, _ thenKeyPath: WritableKeyPath<Root, Value>)
	{
		self.ifKeyPath = ifKeyPath
		
		super.init(thenKeyPath)
	}
	
	public override func write(value: Value, toObject root: inout Root)
	{
		if Optional(root[keyPath: self.ifKeyPath]) != nil {
			super.write(value: value, toObject: &root)
		}
	}
}




