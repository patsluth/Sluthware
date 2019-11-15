//
//  FloatingPointType.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import CoreGraphics


// TODO: Move
precedencegroup ExponentPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator ^^: ExponentPrecedence

public func ^^<B, E>(base: B, exponent: E) -> B
    where B: FloatingPointType, E: FloatingPointType
{
    return B(pow(Double(base), Double(exponent)))
}

public func ^^<B, E>(base: B, exponent: E) -> B
    where B: FloatingPointType, E: IntegerType
{
    return base ^^ B(exponent)
}

public func ^^<B, E>(base: B, exponent: E) -> B
    where B: IntegerType, E: IntegerType
{
    return B(Double(base) ^^ exponent)
}




public protocol FloatingPointType: BinaryFloatingPoint
{
	init(_ value: Float)
	init(_ value: Double)
	init(_ value: CGFloat)
	
	func cast<T: FloatingPointType>() -> T
}

extension Float:	FloatingPointType { public func cast<T: FloatingPointType>() -> T { return T(self) } }
extension Double:	FloatingPointType { public func cast<T: FloatingPointType>() -> T { return T(self) } }
extension CGFloat:	FloatingPointType { public func cast<T: FloatingPointType>() -> T { return T(self) } }

public extension FloatingPointType
{
//    init<F>(_ floatingPoint: F)
//        where F: FloatingPointType
//    {
//        self = Self(floatingPoint)
//    }
    
    init<I>(_ integer: I)
        where I: IntegerType
    {
        self.init(integer)
    }
    
//    func to(the power: Self) -> Self
//    {
//        return Self(pow(Double(self), Double(power)))
//    }
}


//
//public protocol PrecisionEquatable {
//    associatedtype Precision
//
//    func isEqual(to: Self, withPrecision precision: Precision) -> Bool
//}



public extension FloatingPointType//: PrecisionEquatable
{
   // typealias Precision = UInt
    
    func withPrecision(_ decimalPlaces: UInt) -> Self
    {
        let offset: Self = 10^^decimalPlaces
        return ((self * offset).rounded() / offset)
    }
    
    func isEqual<O>(to: O, withPrecision decimalPlaces: UInt) -> Bool
        where O: FloatingPointType
    {
        return self.withPrecision(decimalPlaces).isEqual(to: Self(to.withPrecision(decimalPlaces)))
    }
}
//    static func +<R>(lhs: Self, rhs: R) -> Self
//        where R: FloatingPointType
//    {
//        return lhs + Self(rhs)
//    }
//    
//    static func +<R>(lhs: Self, rhs: R) -> R
//        where R: FloatingPointType
//    {
//        return R(lhs) + rhs
//    }
//    
//    static func +=<R>(lhs: inout Self, rhs: R)
//        where R: FloatingPointType
//    {
//        lhs = lhs + rhs
//    }
//    
//    
//    
//    static func -<R>(lhs: Self, rhs: R) -> Self
//        where R: FloatingPointType
//    {
//        return lhs - Self(rhs)
//    }
//    
//    static func -<R>(lhs: Self, rhs: R) -> R
//        where R: FloatingPointType
//    {
//        return R(lhs) - rhs
//    }
//    
//    static func -=<R>(lhs: inout Self, rhs: R)
//        where R: FloatingPointType
//    {
//        lhs = lhs - rhs
//    }
//    
//    
//    
//    static func *<R>(lhs: Self, rhs: R) -> Self
//        where R: FloatingPointType
//    {
//        return lhs * rhs
//    }
//    
//    static func *<R>(lhs: Self, rhs: R) -> R
//        where R: FloatingPointType
//    {
//        return R(lhs) * rhs
//    }
//    
//    static func *=<R>(lhs: inout Self, rhs: R)
//        where R: FloatingPointType
//    {
//        lhs = lhs * rhs
//    }
//    
//    
//    
//    static func /<R>(lhs: Self, rhs: R) -> Self
//        where R: FloatingPointType
//    {
//        return lhs / rhs
//    }
//    
//    static func /<R>(lhs: Self, rhs: R) -> R
//        where R: FloatingPointType
//    {
//        return R(lhs) / rhs
//    }
//    
//    static func /=<R>(lhs: inout Self, rhs: R)
//        where R: FloatingPointType
//    {
//        lhs = lhs / rhs
//    }
//}





//public extension Float
//{
//	public init<T: FloatingPointType>(_ value: T)
//	{
//		let _value: Float = value.to()
//		self.init(_value)
//	}
//}
//
//public extension Double
//{
//	public init<T: FloatingPointType>(_ value: T)
//	{
//		let _value: Double = value.to()
//		self.init(_value)
//	}
//}
//
//public extension CGFloat
//{
//	public init<T: FloatingPointType>(_ value: T)
//	{
//		let _value: CGFloat = value.to()
//		self.init(_value)
//	}
//}
public extension FloatingPointType
{
    typealias Parts = (integer: Int, decimal: Self)
    
    var parts: Parts {
        return Parts(integer: Int(floor(self)),
                     decimal: self.truncatingRemainder(dividingBy: 1.0))
    }
}




