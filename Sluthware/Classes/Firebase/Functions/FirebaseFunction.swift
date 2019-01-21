//
//  FirebaseFunction.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-01-19.
//  Copyright © 2019 Pat Sluth. All rights reserved.
//

import Foundation

import FirebaseFunctions
import PromiseKit







// TODO: Move to Default
//public protocol DecodableError: Error & Decodable
//{
//}
public typealias DecodableError = (Error & Decodable)

// TODO: Move to Default
//public protocol APIErrorCodeProtocol: RawRepresentable & Decodable
//	where Self.RawValue: Decodable
//{
//
//}

//public protocol APIErrorProtocol: Error
//{
//	associatedtype CodeType: RawRepresentable
//
//	var code: Code { get }
//	var message: String { get }
//	public let message: String
//	associatedtype CodeType: APIErrorCodeProtocol
//}





public class APIResponse: Decodable, ReflectedStringConvertible
{
	private enum CodingKeys: String, CodingKey
	{
		case message = "success"
	}
	
	public let message: String
}

public class APIValueResponse<Value>: APIResponse
	where Value: Decodable
{
	private enum CodingKeys: String, CodingKey
	{
		case value
	}
	
	public let value: Value
	
	required init(from decoder: Decoder) throws
	{
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.value = try container.decode(Value.self, forKey: .value)
		
		try super.init(from: decoder)
	}
}





// TODO: Moove to Default
public extension Error
{
	var ns: NSError {
		return self as NSError
	}
	
	func raw<CodeType>(_ type: CodeType.Type) -> RawError<CodeType>
		where CodeType: RawRepresentable, CodeType.RawValue == Int
	{
		if let rawError = self as? RawError<CodeType> {
			return rawError
		}
		return RawError<CodeType>(self._code, self.localizedDescription)
	}
}

public struct RawError<CodeType>: Error, ReflectedStringConvertible
	where CodeType: RawRepresentable
{
	public enum Code: ReflectedStringConvertible
	{
		case Type(CodeType)
		case Undefined(CodeType.RawValue)
		
		public var rawValue: CodeType.RawValue
		{
			switch self {
			case .Type(let codeType):			return codeType.rawValue
			case .Undefined(let codeValue):		return codeValue
			}
		}
		
		public init(rawValue: CodeType.RawValue)
		{
			if let codeType = CodeType(rawValue: rawValue) {
				self = .Type(codeType)
			} else {
				self = .Undefined(rawValue)
			}
		}
	}
	
	
	
	
	
	public let code: Code
	public let message: String
	
	
	
	
	
	public init(_ code: Code, _ message: String)
	{
		self.code = code
		self.message = message
	}
	
	public init(_ rawValue: CodeType.RawValue, _ message: String)
	{
		self.init(Code(rawValue: rawValue), message)
	}
}





//public extension APIError
//{
//	public init(rawValue: CodeType.RawValue, meessage: String)
//	{
//		self.init(code: Code(rawValue: rawValue), message: message)
//	}
//}





extension RawError: Decodable
	where CodeType.RawValue: Decodable
{
	private enum CodingKeys: String, CodingKey
	{
		case code
		case message = "error"
	}
	
	
	
	
	
	public init(from decoder: Decoder) throws
	{
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		self.init(try container.decode(Code.self, forKey: .code),
				  try container.decode(String.self, forKey: .message))
	}
}





extension RawError.Code: Decodable
	where CodeType.RawValue: Decodable
{
	public init(from decoder: Decoder) throws
	{
		let container = try decoder.singleValueContainer()
		
		self = RawError.Code(rawValue: try container.decode(CodeType.RawValue.self))
	}
}





open class FirebaseFunction<Input, Output>
{
	public let endpoint: String
	fileprivate let errorType: DecodableError.Type
	
	
	
	
	
	public init(_ endpoint: String, errorType: DecodableError.Type)
	{
		self.endpoint = endpoint
		self.errorType = errorType
	}
}





public extension FirebaseFunction
{
	fileprivate func _call(data: Any? = nil) -> Promise<Any>
	{
		return Functions.functions()
			.httpsCallable(self.endpoint)
			.callPromise(data)
	}
	
	public func call(data: Any? = nil) -> Promise<APIResponse>
	{
		return self._call(data: data)
			.then({ responseData in
				APIResponse.decodePromise(responseData)
					.recover({ error -> Promise<APIResponse> in
						if let apiError = try? self.errorType.decode(responseData) {
							throw apiError
						} else {
							throw error
						}
					})
			})
	}
}





public extension FirebaseFunction
	where Input: Encodable
{
	func call(_ input: Input) -> Promise<APIResponse>
	{
		return input.encodePromise([String: Any].self)
			.then({ data in
				self._call(data: data)
			})
			.then({ responseData in
				APIResponse.decodePromise(responseData)
					.recover({ error -> Promise<APIResponse> in
						if let apiError = try? self.errorType.decode(responseData) {
							throw apiError
						} else {
							throw error
						}
					})
			})
	}
}





public extension FirebaseFunction
	where Input: Encodable, Output: Decodable
{
	func call(_ input: Input) -> Promise<APIValueResponse<Output>>
	{
		return input.encodePromise([String: Any].self)
			.then({ data in
				self._call(data: data)
			})
			.then({ responseData in
				APIValueResponse<Output>.decodePromise(responseData)
					.recover({ error -> Promise<APIValueResponse<Output>> in
						if let apiError = try? self.errorType.decode(responseData) {
							throw apiError
						} else {
							throw error
						}
					})
			})
	}
}




