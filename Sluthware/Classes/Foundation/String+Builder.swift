//
//  String+Builder.swift
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





public typealias StringBuilder = String.Builder

public extension String
{
	public struct Builder
	{
		public typealias RawAttribute = (NSAttributedString.Key, Any)
		private typealias Attributes = [NSAttributedString.Key: Any]
		
		fileprivate(set) public var attributed = NSMutableAttributedString()
		
		public var string: String {
			return self.attributed.string
		}
		
		
		
		
		
		public init()
		{
		}
		
		public init(_ string: String, _ rawAttributes: RawAttribute...)
		{
			self._append(string, self.attributes(for: rawAttributes))
		}
		
		@discardableResult
		public func append(_ string: String?, _ rawAttributes: RawAttribute...) -> StringBuilder
		{
			guard let string = string else { return self }
			
			return self._append(string, self.attributes(for: rawAttributes))
		}
		
		@discardableResult
		public func append(line: String?, _ rawAttributes: RawAttribute...) -> StringBuilder
		{
			guard let line = line else { return self }
			
			return self._append(line: line, self.attributes(for: rawAttributes))
		}
		
		@discardableResult
		private func _append(_ string: String, _ attributes: Attributes?) -> StringBuilder
		{
			self.attributed.append(NSAttributedString(string: string, attributes: attributes))
			
			return self
		}
		
		@discardableResult
		private func _append(line: String, _ attributes: Attributes?) -> StringBuilder
		{
			self.attributed.append(NSAttributedString(string: "\n" + line, attributes: attributes))
			
			return self
		}
		
		@discardableResult
		public mutating func clear() -> StringBuilder
		{
			self.attributed = NSMutableAttributedString()
			
			return self
		}
		
		private func attributes(for rawAttributes: [RawAttribute]) -> Attributes?
		{
			guard !rawAttributes.isEmpty else { return nil }
			
			return rawAttributes.reduce(into: Attributes()) { result, element in
				result[element.0] = element.1
			}
		}
	}
}





