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
	
	
	
	
	
	public static func Decoding<T>(_ type: T.Type, codingPath: [CodingKey]) -> DecodingError
	{
		let context = DecodingError.Context(codingPath: [], debugDescription: "Failed to decode \(T.self)")
		return DecodingError.dataCorrupted(context)
	}
	
	public static func Encoding<T>(_ value: T, codingPath: [CodingKey]) -> EncodingError
	{
		let context = EncodingError.Context(codingPath: [], debugDescription: "Failed to encode \(T.self)")
		return EncodingError.invalidValue(value, context)
	}
	
	public static func Log(file: String = #file,
						   function: String = #function,
						   line: Int = #line,
						   _ message: String) -> Errors
	{
		return Errors.Message("\(file.fileNameFull) \(function) \(line) \(message)")
	}
}





extension Errors: CustomStringConvertible
{
	public var description: String {
		switch self {
		case Errors.Init(let type):
			return "Error.Init(\(type))"
		case Errors.Message(let message):
			return "Error.Message(\(message))"
		}
	}
}




