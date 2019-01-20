//
//  FirebaseFunction.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-01-19.
//  Copyright © 2019 Pat Sluth. All rights reserved.
//

import Foundation

import Firebase
import FirebaseFunctions
import PromiseKit





public protocol APIErrorCodeProtocol: RawRepresentable & Decodable
	where Self.RawValue: Decodable
{
	
}

public protocol AnyAPIError: Error & Decodable
{
}

public protocol APIErrorProtocol: AnyAPIError
{
	associatedtype CodeType: APIErrorCodeProtocol
}





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





public struct APIError<_CodeType>: APIErrorProtocol, ReflectedStringConvertible
	where _CodeType: APIErrorCodeProtocol
{
	public typealias CodeType = _CodeType
	
	private enum CodingKeys: String, CodingKey
	{
		case code
		case message = "error"
	}
	
	public let code: Code
	public let message: String
}





public extension APIError
{
	public enum Code: Decodable, ReflectedStringConvertible
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
		
		public init(from decoder: Decoder) throws
		{
			let container = try decoder.singleValueContainer()

			self = Code(rawValue: try container.decode(CodeType.RawValue.self))
		}
	}
}





open class FirebaseFunction<Input, Output>
{
	public let endpoint: String
	fileprivate let errorType: AnyAPIError.Type
	
	
	
	
	
	public init<T>(_ endpoint: String, errorType: T.Type)
		where T: APIErrorProtocol
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




