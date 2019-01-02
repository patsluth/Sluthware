//
//  FloatingPointType.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import CoreGraphics





public protocol NumericType: Numeric
{
	// FloatingPointType
	init(_ value: Float)
	init(_ value: Double)
	init(_ value: CGFloat)
	// IntegerType
	init(_ value: Int)
	init(_ value: UInt)
	init(_ value: Int8)
	init(_ value: UInt8)
	init(_ value: Int16)
	init(_ value: UInt16)
	init(_ value: Int32)
	init(_ value: UInt32)
	init(_ value: Int64)
	init(_ value: UInt64)
	
	func to<T: NumericType>() -> T
}

public extension NumericType
{
	static var zero: Self {
		return (0).to()
	}
}

// FloatingPointType
extension Float:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension Double:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension CGFloat:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }
// IntegerType
extension Int:		NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension UInt:		NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension Int8:		NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension UInt8:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension Int16:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension UInt16:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension Int32:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension UInt32:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension Int64:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }
extension UInt64:	NumericType { public func to<T: NumericType>() -> T { return T(self) } }




