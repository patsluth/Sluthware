//
//  Alamofire+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-26.
//

import Foundation

import Alamofire





/// Alamofire extension that attempts to decode response
public extension DataRequest
{
	@discardableResult
	func response<T>(type: T.Type,
					 queue: DispatchQueue? = nil,
					 options: JSONSerialization.ReadingOptions = .allowFragments,
					 completionHandler: @escaping (DataResponse<T>) -> Void) -> Self
		where T: Decodable
	{
		return self.responseJSON(completionHandler: { response in
			switch response.result {
			case .success(let json):
				completionHandler(DataResponse<T>(request: response.request,
												  response: response.response,
												  data: response.data,
												  result: Result(json)))
			case .failure(let error):
				completionHandler(DataResponse<T>(request: response.request,
												  response: response.response,
												  data: response.data,
												  result: Result.failure(error)))
			}
		})
		//		return response(
		//			queue: queue,
		//			responseSerializer: DataRequest.jsonResponseSerializer(options: options),
		//			completionHandler: completionHandler
		//		)
	}
}





public extension Alamofire.Result
	where Value: Decodable
{
	init(_ value: Any)
	{
		do {
			self = .success(try Value.decode(value))
		} catch {
			self = .failure(error)
		}
	}
}




