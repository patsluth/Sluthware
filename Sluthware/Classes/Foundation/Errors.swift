//
//  Errors.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public enum Errors: Error
{
	case Init(Any.Type)
	case Message(String)
	case Decoding(Any.Type, [CodingKey])
	case Encoding(Any.Type, [CodingKey])
}





extension Errors: CustomStringConvertible
{
	public var description: String {
		switch self {
		case Errors.Init(let type):
			return "Error.Init(\(type))"
		case Errors.Message(let message):
			return "Error.Message(\(message))"
		case Errors.Decoding(let type, let codingPath):
			return "Error.Decoding(\(type) \(String(codingPath, ",")))"
		case Errors.Encoding(let type, let codingPath):
			return "Error.Encoding(\(type) \(String(codingPath, ",")))"
		}
	}
}




