//
//  WeakReference.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public final class WeakReference<T>
	where T: AnyObject
{
	public fileprivate(set) weak var value: T?
	
	
	
	
	
	public init(_ value: T?)
	{
		self.value = value
	}
}





extension WeakReference: Equatable
{
	public static func ==(lhs: WeakReference<T>, rhs: WeakReference<T>) -> Bool
	{
		return lhs.value === rhs.value
	}
}





extension WeakReference: CustomStringConvertible
{
	public var description: String {
		return String(describing: self.value)
	}
}





extension WeakReference: CustomDebugStringConvertible
{
	public var debugDescription: String {
		return self.description
	}
}




