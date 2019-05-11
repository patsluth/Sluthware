//
//  Array.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Array
{
	public mutating func popFirst() -> Element?
	{
		if let first = self.first {
			self.removeFirst()
			return first
		}
		
		return nil
	}
	
	public mutating func popLast() -> Element?
	{
		if let last = self.last {
			self.removeLast()
			return last
		}
		
		return nil
	}
	
	public static func +(lhs: Array<Element>, rhs: Element) -> Array<Element>
	{
		var lhs = lhs
		lhs += rhs
		return lhs
	}
	
	public static func +=(lhs: inout Array<Element>, rhs: Element)
	{
		lhs.append(rhs)
	}
}




