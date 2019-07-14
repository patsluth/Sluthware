//
//  DateInRegion+Codable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-04-04.
//

import Foundation

import SwiftDate





public extension KeyedEncodingContainer
{
	mutating func encodeDateInRegion(_ value: DateInRegion,
							forKey key: Key,
							transform: ((DateInRegion) -> String)? = nil) throws
	{
		let string = transform?(value) ?? value.toISO()
		try self.encode(string, forKey: key)
	}
	
	mutating func encodeDateInRegion(_ value: DateInRegion?,
									 forKey key: Key,
									 transform: ((DateInRegion?) -> String?)? = nil) throws
	{
		let string = transform?(value) ?? value?.toISO()
		try self.encodeIfPresent(string, forKey: key)
	}
}





public extension KeyedDecodingContainer
{
	func decodeDateInRegion(forKey key: Key,
							transform: ((String) -> DateInRegion)? = nil) throws -> DateInRegion
	{
		let string = try self.decode(String.self, forKey: key)
		if let dateInRegion = transform?(string) ?? string.toISODate() {
			return dateInRegion
		}
		throw Sluthware.Errors.Decoding(DateInRegion.self, codingPath: [key])
	}
	
	func decodeDateInRegion(forKey key: Key,
							transform: ((String?) -> DateInRegion?)? = nil) throws -> DateInRegion?
	{
		let string = try self.decodeIfPresent(String.self, forKey: key)
		return transform?(string) ?? string?.toISODate()
	}
}




