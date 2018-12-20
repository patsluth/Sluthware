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
	public var num: Int
	public var den: Int {
		didSet
		{
			if self.den == 0 {
				self.den = oldValue
			}
		}
	}
	
	
	
	
	
	public init(num: IntegerLiteralType, den: IntegerLiteralType)
	{
		self.num = num;
		self.den = den;
	}
	
	public init<T>(_ value: T, precision: T = 1.0e6)
		where T: FloatingPointType
	{
		let parts = value.parts
		
		let decimalFraction: Fraction = {
			let integral = floor(parts.decimal)
			let fractional = parts.decimal - integral
			
			let gcd = Math.gcd(round(fractional * precision), precision)
			
			let num = round(fractional * precision) / gcd
			let den = precision / gcd
			
			return Fraction(num: Int(num), den: Int(den))
		}()
		
		self.num = (parts.integer * decimalFraction.den) + decimalFraction.num
		self.den = decimalFraction.den
	}
	
	public init<T>(_ value: T, over den: IntegerLiteralType)
		where T: FloatingPointType
	{
		let parts = value.parts
		
		let f1 = Fraction(num: parts.integer * den,
						  den: den)
		let f2 = Fraction(num: Int(round(parts.decimal * T(den))),
						  den: den)
		
		self.init(num: f1.num + f2.num,
				  den: den)
	}
	
	//	public init<T>(_ t: T, den: Int)
	//		where T: FloatingPointType
	//	{
	//		let parts = t.parts
	//
	//		self.num = Int(round(parts.decimal * T(den)))
	//		self.den = den
	//	}
	
	public mutating func reduce()
	{
		self = self.reduced()
	}
	
	public func reduced() -> Fraction
	{
		let gcd = Math.gcd(self.num, self.den)
		
		return Fraction(num: self.num / gcd,
						den: self.den / gcd)
	}
}





extension Fraction: CustomStringConvertible
{
	public var description: String {
		return "\(self.num)/\(self.den)"
	}
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
	
	public class func gcd(_ x: IntegerLiteralType, _ y: IntegerLiteralType) -> Int
	{
		return (y == 0) ? x : Math.gcd(y, x % y)
	}
}





public extension FloatingPointType
{
	public typealias Parts = (integer: Int, decimal: Self)
	
	public var parts: Parts {
		return Parts(integer: Int(floor(self)),
					 decimal: self.truncatingRemainder(dividingBy: 1.0))
	}
}




