//
//  Fraction.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public struct Fraction
{
	public let num: Int
	public let den: Int
	
	public let doubleValue: Double
	
	
	
	
	
	public init(_ num: Int, _ den: Int = 1)
	{
		self.num = num
		self.den = den
		self.doubleValue = (Double(self.num) / Double(self.den))
	}
	
	public init<T>(_ value: T, precision: T = 1.0e6)
		where T: FloatingPointType
	{
		let parts = value.parts
		
		let fraction: Fraction = {
			let integral = floor(parts.decimal)
			let fractional = parts.decimal - integral
			
			let gcd = Math.gcd(round(fractional * precision), precision)
			
			let num = round(fractional * precision) / gcd
			let den = precision / gcd
			
			return Fraction(Int(num), Int(den))
		}()
		
		self.num = (parts.integer * fraction.den) + fraction.num
		self.den = fraction.den
		self.doubleValue = Double(value)
	}
	
	public mutating func reduce()
	{
		self = self.reduced()
	}
	
	public func reduced() -> Fraction
	{
		let gcd = Math.gcd(self.num, self.den)
		
		return Fraction(self.num / gcd,
						self.den / gcd)
	}
	
	
	
	public mutating func roundTo(den: Int)
	{
		self = self.roundedTo(den: den)
	}
	
	public func roundedTo(den: Int) -> Fraction
	{
		guard self.isFinite else { return self }
		
		let parts = self.doubleValue.parts
		let num = (parts.integer * den) + Int(round(parts.decimal * den.to()))
		
		return Fraction(num, den)
	}
	
	public func absolute() -> Fraction
	{
		return Fraction(abs(self.num), abs(self.den))
	}
}





extension Fraction
{
	public var reciprocol: Fraction {
		return Fraction(self.den, self.num)
	}
	
	public var sign: FloatingPointSign {
		return self.doubleValue.sign
	}
	
	public var isFinite: Bool {
		return self.magnitude.isFinite
	}
	
	public var isInfinite: Bool {
		return self.magnitude.isInfinite
	}
	
	public var isNaN: Bool {
		return self.magnitude.isNaN
	}
	
	public var isZero: Bool {
		return self.doubleValue.isZero
	}
	
	public var isProper: Bool {
		guard self.isFinite else { return false }
		return (self.den != 0 && fabs(self.doubleValue) < 1.0)
//		return (self.den != 0 && abs(self.num) < abs(self.den))
	}
	
	public var isImproper: Bool {
		guard self.isFinite else { return false }
		return (self.den != 0 && fabs(self.doubleValue) >= 1.0)
//		return (self.den != 0 && abs(self.num) >= abs(self.den))
	}
}





public extension Fraction
{
	public typealias MixedNumber = (whole: Int, fraction: Fraction)
	
	
	
	
	
	/// Convert fraction to a whole number and proper fraction
	public func asMixedNumber(reduced: Bool = true) -> MixedNumber
	{
		var mixedNumber = MixedNumber(whole: 0, fraction: self)
		
		while mixedNumber.fraction.isImproper {
			mixedNumber.whole += 1
			
			switch mixedNumber.fraction.sign {
			case .plus: 	mixedNumber.fraction -= 1
			case .minus: 	mixedNumber.fraction += 1
			}
		}
		
		
		
		switch mixedNumber.fraction.sign {
		case .plus:
			break
		case .minus:
			mixedNumber.whole *= -1
			mixedNumber.fraction = mixedNumber.fraction.absolute()
		}
		
		
		
		if reduced {
			mixedNumber.fraction.reduce()
		}
		
		return mixedNumber
	}
}





extension Fraction
{
	public static var infinity: Fraction {
		return Fraction(1, 0)
	}
	
	public static var NaN: Fraction {
		return Fraction(0, 0)
	}
	
	public static var zero: Fraction {
		return Fraction(0, 1)
	}
}





extension Fraction: Equatable
{
	public static func ==(lhs: Fraction, rhs: Fraction) -> Bool
	{
		return (lhs.doubleValue == rhs.doubleValue)
	}
}





extension Fraction: Comparable
{
	public static func <(lhs: Fraction, rhs: Fraction) -> Bool
	{
		return (lhs.doubleValue < rhs.doubleValue)
	}
	
	public static func <=(lhs: Fraction, rhs: Fraction) -> Bool
	{
		return (lhs.doubleValue <= rhs.doubleValue)
	}
	
	public static func >(lhs: Fraction, rhs: Fraction) -> Bool
	{
		return (lhs.doubleValue > rhs.doubleValue)
	}
	
	public static func >=(lhs: Fraction, rhs: Fraction) -> Bool
	{
		return (lhs.doubleValue > rhs.doubleValue)
	}
	
	
	
	public static func <<T>(lhs: Fraction, rhs: T) -> Bool
		where T: Sluthware.FloatingPointType
	{
		return (lhs.doubleValue < Double(rhs))
	}
	
	public static func <=<T>(lhs: Fraction, rhs: T) -> Bool
		where T: Sluthware.FloatingPointType
	{
		return (lhs.doubleValue <= Double(rhs))
	}
	
	public static func ><T>(lhs: Fraction, rhs: T) -> Bool
		where T: Sluthware.FloatingPointType
	{
		return (lhs.doubleValue > Double(rhs))
	}
	
	public static func >=<T>(lhs: Fraction, rhs: T) -> Bool
		where T: Sluthware.FloatingPointType
	{
		return (lhs.doubleValue > Double(rhs))
	}
	
	
	
	public static func <<T>(lhs: Fraction, rhs: T) -> Bool
		where T: Sluthware.IntegerType
	{
		return (lhs.doubleValue < Double(rhs))
	}
	
	public static func <=<T>(lhs: Fraction, rhs: T) -> Bool
		where T: Sluthware.IntegerType
	{
		return (lhs.doubleValue <= Double(rhs))
	}
	
	public static func ><T>(lhs: Fraction, rhs: T) -> Bool
		where T: Sluthware.IntegerType
	{
		return (lhs.doubleValue > Double(rhs))
	}
	
	public static func >=<T>(lhs: Fraction, rhs: T) -> Bool
		where T: Sluthware.IntegerType
	{
		return (lhs.doubleValue > Double(rhs))
	}
}





extension Fraction: Hashable
{
	public func hash(into hasher: inout Hasher)
	{
		hasher.combine(self.doubleValue)
	}
}





extension Fraction: ExpressibleByIntegerLiteral
{
	public init(integerLiteral value: Int)
	{
		self.init(value, 1)
	}
}





extension Fraction: ExpressibleByFloatLiteral
{
	public init(floatLiteral value: Double)
	{
		self.init(value)
	}
}





extension Fraction: SignedNumeric
{
	public var magnitude: Double {
		return self.doubleValue.magnitude
	}
	
	
	
	
	
	public init?<T>(exactly source: T)
		where T: BinaryInteger
	{
		self.init(Int(source), 1)
	}
	
	prefix public static func -(operand: Fraction) -> Fraction
	{
		return Fraction(operand.num * -1, operand.den)
	}
}





extension Fraction: Addable
{
	public static func +(lhs: Fraction, rhs: Fraction) -> Fraction
	{
		let num = (lhs.num * rhs.den) + (lhs.den * rhs.num)
		let den = (lhs.den * rhs.den)
		
		return Fraction(num, den)//.reduced()
	}
	
	public static func +=(lhs: inout Fraction, rhs: Fraction)
	{
		lhs = lhs + rhs
	}
}





extension Fraction: Subtractable
{
	public static func -(lhs: Fraction, rhs: Fraction) -> Fraction
	{
		return lhs + Fraction(rhs.num * -1, rhs.den)
	}
	
	public static func -=(lhs: inout Fraction, rhs: Fraction)
	{
		lhs = lhs - rhs
	}
}





extension Fraction: Multipliable
{
	public static func *(lhs: Fraction, rhs: Fraction) -> Fraction
	{
		let num = lhs.num * rhs.num
		let den = lhs.den * rhs.den
		
		return Fraction(num, den)//.reduced()
	}
	
	public static func *=(lhs: inout Fraction, rhs: Fraction)
	{
		lhs = lhs * rhs
	}
}





extension Fraction: Dividable
{
	public static func /(lhs: Fraction, rhs: Fraction) -> Fraction
	{
		return lhs * rhs.reciprocol
	}
	
	public static func /=(lhs: inout Fraction, rhs: Fraction)
	{
		lhs = lhs / rhs
	}
}





extension Fraction: CustomStringConvertible
{
	public var description: String {
		return "\(self.num)/\(self.den)"
	}
}




