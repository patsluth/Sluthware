//
//  Decodable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Decodable
{
	static func decode<T>(_ value: T, decoder: JSONDecoder? = nil) throws -> Self
	{
		let decoder = decoder ?? {
			let _decoder = JSONDecoder()
			_decoder.dateDecodingStrategy = .formatted(DateFormatter.properISO8601)
			return _decoder
			}()
		
		switch value {
		case let value as Self:
			return value
		case let data as Data:
			return try decoder.decode(Self.self, from: data)
		case let string as String:
			if let data = string.removingPercentEncodingSafe.data(using: .utf8) {
				return try Self.decode(data, decoder: decoder)
			}
		default:
			if JSONSerialization.isValidJSONObject(value) {
				let data = try JSONSerialization.data(withJSONObject: value)
				return try Self.decode(data, decoder: decoder)
			}
		}
		
		throw Errors.Decoding(T.self, codingPath: [])
	}
}




