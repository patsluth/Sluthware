//
//  Encodable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Encodable
{
	func encode<T>(_ type: T.Type) throws -> T
	{
		let encoder = JSONEncoder()
		encoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted
		let data = try encoder.encode(self)
		
		switch type {
		case is Data.Type:
			return data as! T
		case is String.Type:
			if let string = String(data: data, encoding: String.Encoding.utf8) {
				return string as! T
			}
		default:
			if let jsonObject = try JSONSerialization.jsonObject(with: data) as? T {
				return jsonObject
			}
		}
		
		throw Errors.Encoding(self, codingPath: [])
	}
}




