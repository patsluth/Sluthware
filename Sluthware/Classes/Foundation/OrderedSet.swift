//
//  OrderedSet.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public struct OrderedSet<Element>: Collection
	where Element: Hashable
{
	public typealias Index = Array<Element>.Index
	
	
	
	
	
	fileprivate(set) var elements = [Element]()
	fileprivate var elementIndices = [Element: OrderedSet.Index]()
	
	public var startIndex: OrderedSet.Index {
		return self.elements.startIndex
	}
	
	public var endIndex: OrderedSet.Index {
		return self.elements.endIndex
	}
	
	public var count: Int {
		return self.elements.count
	}
	
	
	
	
	
	public init()
	{
	}
	
	public mutating func add(_ element: Element)
	{
		guard !self.contains(element) else { return }
		
		self.elements.append(element)
		self.elementIndices[element] = self.elements.endIndex - 1
	}
	
	public mutating func insert(_ element: Element, at index: OrderedSet.Index)
	{
		guard !self.contains(element) else { return }
		
		self.elements.insert(element, at: index)
		
		for i in stride(from: index, to: self.elements.endIndex, by: 1) {
			self.elementIndices[self.elements[i]] = i
		}
	}
	
	//	public mutating func remove(_ element: Element)
	//	{
	//		guard let elementIndex = self.elementIndices[element] else { return }
	//
	//		self.remove(at: elementIndex)
	//	}
	//
	//	@discardableResult
	//	public mutating func remove(at index: OrderedSet.Index) -> Element?
	//	{
	//		guard let elementIndex = self.elementIndices[element] else { return nil }
	//
	//		let element = self.elements.remove(at: elementIndex)
	//		self.elementIndices[element] = nil
	//
	//		for i in stride(from: index, to: self.elements.endIndex, by: 1) {
	//			self.elementIndices[self.elements[i]] = i
	//		}
	//
	//		return element
	//	}
	
	public func contains(_ element: Element) -> Bool
	{
		return (self.elementIndices[element] != nil)
	}
	
	public func index(of element: Element) -> OrderedSet.Index?
	{
		return self.elementIndices[element]
	}
	
	public func index(after i: OrderedSet.Index) -> OrderedSet.Index
	{
		return self.elements.index(after: i)
	}
	
	public subscript (index: OrderedSet.Index) -> Element
	{
		return self.elements[index]
	}
}





extension OrderedSet: ExpressibleByArrayLiteral
{
	public typealias ArrayLiteralElement = Element
	
	public init(arrayLiteral elements: Element...)
	{
		elements.forEach({
			self.add($0)
		})
	}
}




extension OrderedSet: CustomStringConvertible
{
	public var description: String {
		return String(format: "%@", self.elements)
	}
}




