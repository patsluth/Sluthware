//
//  StringBuilder.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-02-13.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation




//extension String
//{
//
//}



//public extension NSAttributedString
//{
//	public static func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString
//	{
//		let attributedString = NSMutableAttributedString()
//		attributedString.append(lhs)
//		attributedString.append(rhs)
//		return attributedString as NSAttributedString
//	}
//	
//	public static func +(lhs: NSAttributedString, rhs: String) -> NSAttributedString
//	{
//		return lhs + NSAttributedString(string: rhs)
//	}
//
//	public static func +=(lhs: inout NSAttributedString, rhs: NSAttributedString)
//	{
//		lhs = lhs + rhs
//	}
//
//	public static func +=(lhs: inout NSAttributedString, rhs: String)
//	{
//		lhs = lhs + rhs
//	}
//}





public struct StringBuilder
{
	fileprivate(set) public var attributed = NSMutableAttributedString()
	
	public var string: String {
		return self.attributed.string
	}
	
	
	
	
	
	public init()
	{
	}
	
	//	public init(string: String, _ rawAttributes: (NSAttributedStringKey, Any)...)
	//	{
	//		self.append(string: string, rawAttributes)
	//	}
	
	@discardableResult public func append(string: String?, _ rawAttributes: (NSAttributedString.Key, Any)...) -> StringBuilder
	{
		guard let string = string else { return self }
		
		let attributes = self.attributesDictionaryFrom(rawAttributes: rawAttributes)
		return self.internalAppend(string: (string, attributes))
	}
	
	@discardableResult public func append(line: String?, _ rawAttributes: (NSAttributedString.Key, Any)...) -> StringBuilder
	{
		guard let line = line else { return self }
		
		let attributes = self.attributesDictionaryFrom(rawAttributes: rawAttributes)
		return self.internalAppend(line: (line, attributes))
	}
	
	@discardableResult fileprivate func internalAppend(string: (String, [NSAttributedString.Key: Any]?)) -> StringBuilder
	{
		self.attributed.append(NSAttributedString(string: string.0, attributes: string.1))
		
		return self
	}
	
	@discardableResult fileprivate func internalAppend(line: (String, [NSAttributedString.Key: Any]?)) -> StringBuilder
	{
		var line = line
		//		if String.isEmpty(self.string) {
		line.0 = "\n" + line.0
		//		s}
		self.attributed.append(NSAttributedString(string: line.0, attributes: line.1))
		
		return self
	}
	
	@discardableResult public mutating func clear() -> StringBuilder
	{
		self.attributed = NSMutableAttributedString()
		
		return self
	}
	
	fileprivate func attributesDictionaryFrom(rawAttributes: [(NSAttributedString.Key, Any)]) -> [NSAttributedString.Key: Any]?
	{
		return rawAttributes.reduce(into: [NSAttributedString.Key: Any]()) { result, element in
			result[element.0] = element.1
		}
	}
}





