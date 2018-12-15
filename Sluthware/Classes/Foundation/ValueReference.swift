//
//  NonObjectReference.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public final class ValueReference<T>
{
	public fileprivate(set) var value: T? {
		didSet
		{
			print("PAT PAT")
		}
	}
	
	
	
	
	
	public init(_ value: T) {
		self.value = value
	}
}





extension ValueReference: Equatable
{
	public static func ==(lhs: ValueReference<T>, rhs: ValueReference<T>) -> Bool
	{
		return lhs === rhs
	}
}





extension ValueReference: CustomStringConvertible
{
	public var description: String {
		return String(describing: self.value)
	}
}





extension ValueReference: CustomDebugStringConvertible
{
	public var debugDescription: String {
		return self.description
	}
}




