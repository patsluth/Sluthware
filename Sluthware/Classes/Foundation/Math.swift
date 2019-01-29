//
//  Math.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public protocol Addable
{
	static func +(lhs: Self, rhs: Self) -> Self
	static func +=(lhs: inout Self, rhs: Self)
}

public protocol Subtractable
{
	static func -(lhs: Self, rhs: Self) -> Self
	static func -=(lhs: inout Self, rhs: Self)
}

public protocol Multipliable
{
	static func *(lhs: Self, rhs: Self) -> Self
	static func *=(lhs: inout Self, rhs: Self)
}

public protocol Dividable
{
	static func /(lhs: Self, rhs: Self) -> Self
	static func /=(lhs: inout Self, rhs: Self)
}

public protocol Modable
{
	static func %(lhs: Self, rhs: Self) -> Self
	static func %=(lhs: inout Self, rhs: Self)
}





public final class Math
{
	private init()
	{
	}
	
	
	
	public class func gcd<T>(_ x: T, _ y: T) -> T
		where T: Sluthware.FloatingPointType
	{
		return (y == 0.0) ? x : Math.gcd(y, x.truncatingRemainder(dividingBy: y))
	}
	
//	public class func gcd<T>(_ x: T, _ y: T) -> T
//		where T: FixedWidthInteger
//	{
//		let x = x.magnitude
//		let y = y.magnitude
//		print(x, y)
//		
//		return (y == 0) ? x : Math.gcd(y, x % y)
////		return self.gcd(UInt(x), UInt(y))
//	}
	
	public class func gcd(_ x: Int, _ y: Int) -> Int
	{
		let remainder = abs(x) % abs(y)
		return (remainder == 0) ? abs(y) : Math.gcd(abs(y), remainder)
	}
}




