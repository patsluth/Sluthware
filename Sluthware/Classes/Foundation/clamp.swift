//
//  clamp.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension ClosedRange
{
	public func clamp(_ value: Bound) -> Bound
	{
		return Swift.min(Swift.max(value, self.lowerBound), self.upperBound)
	}
}





public extension Range
{
	public func clamp(_ value: Bound) -> Bound
	{
		return Swift.min(Swift.max(value, self.lowerBound), self.upperBound)
	}
}





//public extension Comparable
//{
//	public mutating func clamp(to closedRange: ClosedRange<Self>)
//	{
//		self = self.clamped(to: closedRange)
//	}
//
//	public func clamped(to closedRange: ClosedRange<Self>) -> Self
//	{
//		return closedRange.clamp(self)
//	}
//}




