//
//  ValueResult.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-06-20.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation





public enum ValueResult<T>
{
	case Success(T)
	case Failure(Error)
	
	
	
	
	
	public var value: T? {
		guard case let .Success(value) = self else { return nil }
		return value
	}
	
	public var error: Error? {
		guard case let .Failure(error) = self else { return nil }
		return error
	}
}





extension ValueResult: Equatable
	where T: Equatable
{
	public static func == (lhs: ValueResult<T>, rhs: ValueResult<T>) -> Bool
	{
		return lhs.value == rhs.value
	}
}





extension ValueResult
	where T: Decodable
{
	public init(_ value: Any)
	{
		do {
			self = .Success(try T.decode(value))
		} catch {
			self = .Failure(error)
		}
	}
}




