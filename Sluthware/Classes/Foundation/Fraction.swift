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
	
	
	
	
	
	public init(_ num: Int, _ den: Int)
	{
		self.num = num
		self.den = den
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
		guard self.type != .Infinite && self.type != .NaN else { return self }
		
		let parts = self.doubleValue.parts
		let num = (parts.integer * den) + Int(round(parts.decimal * den.to()))
		
		return Fraction(num, den)
	}
	
	
	
	public typealias MixedNumber = (whole: Int, fraction: Fraction)
	
	public func asMixedNumber() -> MixedNumber
	{
		var mixedNumber = MixedNumber(whole: 0, fraction: self)
		
		while mixedNumber.fraction.type == .Improper {
			mixedNumber.fraction -= 1
			mixedNumber.whole += 1
		}
		
		return mixedNumber
//		let parts = self.doubleValue.parts
//
//		return MixedNumber(whole: parts.integer,
//						   fraction: Fraction(parts.decimal).roundedTo(den: self.den))
	}
}





extension Fraction
{
	public var type: FractionType {
		return FractionType(fraction: self)
	}
	
	public var doubleValue: Double {
		return (Double(self.num) / Double(self.den))
	}
	
	public var reciprocol: Fraction {
		return Fraction(self.den, self.num)
	}
}





public enum FractionType
{
	case Zero
	case Proper
	case Improper
	case Infinite
	case NaN
	
	fileprivate init(fraction f: Fraction)
	{
		if f.den == 0 {
			self = (f.num != 0 ) ? .Infinite : .NaN
		} else {
			if f.num == 0 {
				self = .Zero
			} else {
				self = (f.num < f.den) ? .Proper : .Improper
			}
		}
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
		return self.doubleValue
	}
	
	
	
	
	
	public init?<T>(exactly source: T) where T : BinaryInteger
	{
		self.num = Int(source)
		self.den = 1
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





public extension FloatingPointType
{
	public typealias Parts = (integer: Int, decimal: Self)
	
	public var parts: Parts {
		return Parts(integer: Int(floor(self)),
					 decimal: self.truncatingRemainder(dividingBy: 1.0))
	}
}





public protocol AttributedFormatterProtocol: class
{
	associatedtype Value

	init()
	func format(_ value: Value) -> NSAttributedString
}





public extension AttributedFormatterProtocol
{
	public init(_ initBlock: (Self) -> Void)
	{
		self.init()
		
		defer {
			initBlock(self)
		}
	}
}





public class AttributedFormatter<_Value>
{
	public typealias Value = _Value
	
	
	
	
	
	fileprivate init()
	{
	}
}





public final class FractionAttributedFormatter: AttributedFormatter<Fraction>, AttributedFormatterProtocol
{
	public var font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
	public var useProperFractions = true
	
	
	
	
	
	public override init()
	{
		super.init()
	}
	
//	public func format(_ value: Fraction) -> NSAttributedString
//	{
//		var attributedString = NSAttributedString()
//
//		switch (value.type, self.useProperFractions) {
//		case (.Zero, _):
//			attributedString = NSAttributedString("0", {
//				$0[NSAttributedString.Key.font] = self.font
//			})
//			break
//		case (.Proper, _):
//			attributedString = NSAttributedString("\(value)", {
//				$0[NSAttributedString.Key.font] = self.font.forFraction()
//			})
//		case (.Improper, false):
//			attributedString = NSAttributedString("\(value)", {
//				$0[NSAttributedString.Key.font] = self.font.forFraction()
//			})
//		case (.Improper, true):
//			let mixedNumber = value.asMixedNumber()
//
//			if mixedNumber.fraction.num != 0 {
//				attributedString = self.format(mixedNumber.fraction)
//			}
//
//			if mixedNumber.whole != 0 {
//				attributedString =
//					NSAttributedString("\(mixedNumber.whole)", {
//						$0[NSAttributedString.Key.font] = self.font
//					}) +
//				attributedString
//			}
//		case (.Infinite, _):
//			attributedString = NSAttributedString("∞", {
//				$0[NSAttributedString.Key.font] = self.font
//			})
//		case (.NaN, _):
//			attributedString = NSAttributedString("NaN", {
//				$0[NSAttributedString.Key.font] = self.font
//			})
//		}
//
//		return attributedString
//	}
	
	public func format(_ value: Fraction) -> NSAttributedString
	{
		var attributedString = NSAttributedString()

		switch (value.doubleValue, self.useProperFractions) {
		case (let x, _) where x.isNaN:
			attributedString = NSAttributedString("NaN", {
				$0[NSAttributedString.Key.font] = self.font
			})
		case (let x, _) where x.isInfinite:
			attributedString = NSAttributedString("∞", {
				$0[NSAttributedString.Key.font] = self.font
			})
		case (let x, _) where x.isZero:
			attributedString = NSAttributedString("0", {
				$0[NSAttributedString.Key.font] = self.font
			})
		// Proper Fraction
		case (let x, _) where fabs(x).isLess(than: 1.0):
			attributedString = NSAttributedString("\(value)", {
				$0[NSAttributedString.Key.font] = self.font.forFraction()
			})
		// Improper Fraction
		case (_, false):
			attributedString = NSAttributedString("\(value)", {
				$0[NSAttributedString.Key.font] = self.font.forFraction()
			})
		// Improper Fraction
		case (_, true):
			let mixedNumber = value.asMixedNumber()
			
			if mixedNumber.fraction.num != 0 {
				attributedString = self.format(mixedNumber.fraction)
			}
			
			if mixedNumber.whole != 0 {
				attributedString = NSAttributedString("\(mixedNumber.whole)", {
					$0[NSAttributedString.Key.font] = self.font
				}) +
				attributedString
			}
		}

		return attributedString
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
	
	public class func gcd<T>(_ x: T, _ y: T) -> T
		where T: FixedWidthInteger
	{
		return (y == 0) ? x : Math.gcd(y, x % y)
	}
}




