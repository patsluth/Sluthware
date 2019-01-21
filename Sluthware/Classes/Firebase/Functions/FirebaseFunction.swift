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





public protocol FirebaseFunctionProtocol
{
	associatedtype Input
	associatedtype Output
	
	static var endpoint: String { get }
}





fileprivate extension FirebaseFunctionProtocol
{
	fileprivate static func _call(data: Any? = nil) -> Promise<Any>
	{
		return Functions.functions()
			.httpsCallable(self.endpoint)
			.callPromise(data)
	}
}





public extension FirebaseFunctionProtocol
	where Input == Void, Output == Void
{
	static func call() -> Promise<Output>
	{
		return self._call()
			.then({ responseData in
				Promise.value(())
				//				APIResponse.decodePromise(responseData)
				//					.recover({ error -> Promise<APIResponse> in
				//						if let apiError = try? self.errorType.decode(responseData) {
				//							throw apiError
				//						} else {
				//							throw error
				//						}
				//					})
			})
	}
}





public extension FirebaseFunctionProtocol
	where Input == Void, Output: Decodable
{
	static func call() -> Promise<Output>
	{
		return self._call()
			.then({ responseData in
				Output.decodePromise(responseData)
				//					.recover({ error -> Promise<APIResponse> in
				//						if let apiError = try? self.errorType.decode(responseData) {
				//							throw apiError
				//						} else {
				//							throw error
				//						}
				//					})
			})
	}
}





public extension FirebaseFunctionProtocol
	where Input: Encodable, Output: Decodable
{
	static func call(_ input: Input) -> Promise<Output>
	{
		return input.encodePromise([String: Any].self)
			.then({ data in
				self._call(data: data)
			})
			.then({ responseData in
				Output.decodePromise(responseData)
				//					.recover({ error -> Promise<APIResponse> in
				//						if let apiError = try? self.errorType.decode(responseData) {
				//							throw apiError
				//						} else {
				//							throw error
				//						}
				//					})
			})
	}
}




