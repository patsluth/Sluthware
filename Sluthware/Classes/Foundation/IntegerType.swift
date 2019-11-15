//
//  IntegerType.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public protocol IntegerType: BinaryInteger
{
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

	func cast<T: IntegerType>() -> T
}

extension Int:		IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }
extension UInt:		IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }
extension Int8:		IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }
extension UInt8:	IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }
extension Int16:	IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }
extension UInt16:	IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }
extension Int32:	IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }
extension UInt32:	IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }
extension Int64:	IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }
extension UInt64:	IntegerType { public func cast<T: IntegerType>() -> T { return T(self) } }

public extension IntegerType {
    init<F>(_ floatingPoint: F)
        where F: FloatingPointType
    {
        self.init(floatingPoint)
    }
    
//    init<I>(_ integer: I)
//        where I: IntegerType
//    {
//        self.init(integer)
//    }
}

public extension IntegerType
{
    static func +<R, T>(lhs: Self, rhs: R) -> T
        where R: IntegerType, T: IntegerType
    {
        return T(lhs) + T(rhs)
    }
    
    static func +=<R>(lhs: inout Self, rhs: R)
        where R: IntegerType
    {
        lhs = lhs + Self(rhs)
    }
    
    
    
    static func -<R, T>(lhs: Self, rhs: R) -> T
        where R: IntegerType, T: IntegerType
    {
        return T(lhs) - T(rhs)
    }
    
    static func -=<R>(lhs: inout Self, rhs: R)
        where R: IntegerType
    {
        lhs = lhs - Self(rhs)
    }
    
    
    
    static func *<R, T>(lhs: Self, rhs: R) -> T
        where R: IntegerType, T: IntegerType
    {
        return T(lhs) * T(rhs)
    }
    
    static func *=<R>(lhs: inout Self, rhs: R)
        where R: IntegerType
    {
        lhs = lhs * Self(rhs)
    }
    
    
    
    static func /<R, T>(lhs: Self, rhs: R) -> T
        where R: IntegerType, T: IntegerType
    {
        return T(lhs) / T(rhs)
    }
    
    static func /=<R>(lhs: inout Self, rhs: R)
        where R: IntegerType
    {
        lhs = lhs / Self(rhs)
    }
}

public extension IntegerType {
    var numberOfDigits: UInt {
        return UInt(ceil(log10(Double(self) + 1)))
    }
}




