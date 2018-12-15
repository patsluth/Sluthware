//
//  Value.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-06-20.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation





public enum ValueResult<V>
{
	public typealias ValueType = V
	
	
	
	
	
	case Success(V)
	case Failure(Error)
	
	
	
	
	
	public var value: ValueType? {
		guard case let .Success(value) = self else { return nil }
		return value
	}
	
	public var error: Error? {
		guard case let .Failure(error) = self else { return nil }
		return error
	}
}





extension ValueResult
	where V: Decodable
{
	public init<T>(_ value: T)
	{
		do {
			self = .Success(try V.decode(value))
		} catch {
			self = .Failure(error)
		}
	}
}




