//
//  TypeContainer.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public protocol AnyTypeContainer
{
	var rootType: Any.Type { get }
	
	func containsMember<T>(_ type: T.Type) -> Bool
	func containsMember<T>(_ type: Optional<T>.Type) -> Bool
	func containsMember<T>(_ object: T) -> Bool
	
	func containsKind<T>(_ type: T.Type) -> Bool
	func containsKind<T>(_ type: Optional<T>.Type) -> Bool
	func containsKind<T>(_ object: T) -> Bool
}





public struct TypeContainer<Root>: AnyTypeContainer
{
	public let rootType: Any.Type = Root.self
	
	
	
	
	
	public init(_ type: Root.Type)
	{
	}
	
	public func containsMember<T>(_ type: T.Type) -> Bool
	{
		return (T.self == Root.self)
	}
	
	public func containsMember<T>(_ type: Optional<T>.Type) -> Bool
	{
		return (T.self == Root.self)
	}
	
	public func containsMember<T>(_ object: T) -> Bool
	{
		return (type(of: object) == Root.self)
	}
	
	public func containsKind<T>(_ type: T.Type) -> Bool
	{
		return (Root.self is T.Type)
	}
	
	public func containsKind<T>(_ type: Optional<T>.Type) -> Bool
	{
		return (Root.self is T.Type)
	}
	
	public func containsKind<T>(_ object: T) -> Bool
	{
		return (object is Root)
	}
}




