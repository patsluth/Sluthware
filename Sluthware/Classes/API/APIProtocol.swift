//
//  APIProtocol.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-06-20.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation

import Alamofire
import PromiseKit





public protocol APIProtocol
{
	associatedtype ErrorType: Error, Decodable
	associatedtype RequestSelector
	
	static var shared: Self { get }
	
	func buildDataRequest<Response>(for apiRequest: APIRequest<Response>) -> Promise<DataRequest>
		where Response: Decodable
}





public extension APIProtocol
{
	public func execute<Response>(_ block: (RequestSelector.Type) -> APIRequest<Response>) -> Promise<Response>
		where Response: Decodable
		//		where T: APIRequestProtocol
	{
		return self.executeInternal(block(RequestSelector.self))
	}
	
	private func executeInternal<Response>(_ apiRequest: APIRequest<Response>) -> Promise<Response>
		where Response: Decodable
		//		where T: APIRequestProtocol
	{
		return Promise { resolver in
			
			self.buildDataRequest(for: apiRequest)
				.done({ dataRequest in
					dataRequest
						.responseJSON(completionHandler: { response in
							switch response.result {
							case .success(let value):
								do {
									resolver.fulfill(try Response.decode(value))
								} catch {
									if let apiError = try? ErrorType.decode(value) {
										resolver.reject(apiError)
									} else {
										resolver.reject(error)
									}
								}
							case .failure(let error):
								resolver.reject(error)
							}
						})
				})
				.catch({ error in
					resolver.reject(error)
				})
		}
	}
}





public struct APIRequest<Response>
	where Response: Decodable
{
	public let endpoint: String
	public let paramaters: [String: Any]?
	public let method: HTTPMethod
	public let encoding: ParameterEncoding
	
	
	
	
	
	public init(endpoint: String,
				paramaters: [String: Any]?,
				method: HTTPMethod,
				encoding: ParameterEncoding)
	{
		self.endpoint = endpoint
		self.paramaters = paramaters
		self.method = method
		self.encoding = encoding
	}
}




