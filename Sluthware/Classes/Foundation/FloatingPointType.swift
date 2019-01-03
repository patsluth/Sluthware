//
//  FloatingPointType.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import CoreGraphics





public protocol FloatingPointType: BinaryFloatingPoint, Codable
{
	init(_ value: IntegerLiteralType)
	init(_ value: Float)
	init(_ value: Double)
	init(_ value: CGFloat)
	
	func to<T: FloatingPointType>() -> T
}

extension Float:	FloatingPointType { public func to<T: FloatingPointType>() -> T { return T(self) } }
extension Double:	FloatingPointType { public func to<T: FloatingPointType>() -> T { return T(self) } }
extension CGFloat:	FloatingPointType { public func to<T: FloatingPointType>() -> T { return T(self) } }





public extension Float
{
	public init<T: FloatingPointType>(_ value: T)
	{
		let _value: Float = value.to()
		self.init(_value)
	}
}





public extension Double
{
	public init<T: FloatingPointType>(_ value: T)
	{
		let _value: Double = value.to()
		self.init(_value)
	}
}





public extension CGFloat
{
	public init<T: FloatingPointType>(_ value: T)
	{
		let _value: CGFloat = value.to()
		self.init(_value)
	}
}





public extension FloatingPointType
{
	public func value(percentage: Self, between min: Self, and max: Self) -> Self
	{
		return ((percentage * (max - min)) + min)
	}
	
	public func percentage(between min: Self, and max: Self) -> Self
	{
		return ((self - min) / (max - min))
	}
	
	public func rounded(to places: Int) -> Self
	{
		let divisor = Self(pow(10.0, Double(places)))
		return (self * divisor).rounded() / divisor
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




