//
//  AnyJSON.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public enum AnyJSON
{
	public enum Value: Codable
	{
		case string(String)
		case int(Int)
		case double(Double)
		case bool(Bool)
		case data(Data)
		case collection(AnyJSON.Collection)
		
		
		
		
		
		public init(from decoder: Decoder) throws
		{
			let container = try decoder.singleValueContainer()
			
			if let value = try? container.decode(String.self) {
				self = .string(value)
			} else if let value = try? container.decode(Int.self) {
				self = .int(value)
			} else if let value = try? container.decode(Double.self) {
				self = .double(value)
			} else if let value = try? container.decode(Bool.self) {
				self = .bool(value)
			} else if let value = try? container.decode(Data.self) {
				self = .data(value)
			} else if let value = try? container.decode(AnyJSON.Collection.self) {
				self = .collection(value)
			} else {
				throw Errors.Decoding(AnyJSON.Collection.self, codingPath: container.codingPath)
			}
		}
		
		public func encode(to encoder: Encoder) throws
		{
			var container = encoder.singleValueContainer()
			
			switch self {
			case .string(let value):
				try container.encode(value)
			case .int(let value):
				try container.encode(value)
			case .double(let value):
				try container.encode(value)
			case .bool(let value):
				try container.encode(value)
			case .data(let value):
				try container.encode(value)
			case .collection(let value):
				try container.encode(value)
			}
		}
	}
	
	
	
	
	
	public enum Collection: Codable
	{
		case dictionary([String: AnyJSON.Value])
		case array([AnyJSON.Value])
		
		
		
		
		
		public init(from decoder: Decoder) throws
		{
			let container = try decoder.singleValueContainer()
			
			if let value = try? container.decode([String: AnyJSON.Value].self) {
				self = .dictionary(value)
			} else if let value = try? container.decode([AnyJSON.Value].self) {
				self = .array(value)
			} else {
				throw Errors.Decoding(AnyJSON.Collection.self, codingPath: container.codingPath)
			}
		}
		
		public func encode(to encoder: Encoder) throws
		{
			var container = encoder.singleValueContainer()
			
			switch self {
			case .dictionary(let value):
				try container.encode(value)
			case .array(let value):
				try container.encode(value)
			}
		}
	}
}




