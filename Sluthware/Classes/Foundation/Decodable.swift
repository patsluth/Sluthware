//
//  Decodable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

#if canImport(Rswift)
import Rswift
#endif





public extension Decodable
{
	static func decode<T>(_ value: T) throws -> Self
	{
		switch value {
		case let data as Data:
			let decoder = JSONDecoder()
			return try decoder.decode(Self.self, from: data)
		case let string as String:
			if let data = string.removingPercentEncodingSafe.data(using: String.Encoding.utf8) {
				return try Self.decode(data)
			}
		default:
			if JSONSerialization.isValidJSONObject(value) {
				let data = try JSONSerialization.data(withJSONObject: value)
				return try Self.decode(data)
			}
		}
		
		throw Errors.Message("\(String(describing: Self.self)) \(#function) failed")
	}
	
	
	
	static func decodePlist(_ fileURL: URL?) throws -> Self
	{
		var value: [AnyHashable: Any]
		if let fileURL = fileURL {
			value = [AnyHashable: Any](contentsOf: fileURL) ?? [:]
			value["fileName"] = fileURL.fileName
		} else {
			value = [:]
		}
		
		return try Self.decode(value)
	}
	
	#if canImport(Rswift)
	static func decodePlist(_ fileResource: FileResource) throws -> Self
	{
		return try Self.decodePlist(fileURL: fileResource.url())
	}
	#endif
}




