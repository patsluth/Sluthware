//
//  ObservableType+ValueResult.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa





public extension ObservableType
{
	public func asValueResult() -> Observable<ValueResult<E>>
	{
		return self
			.materialize()
			.flatMap({ event -> Observable<ValueResult<E>> in
				switch event {
				case .next(let value):		return .just(.Success(value))
				case .error(let error):		return .just(.Failure(error))
				case .completed:  			return .empty()
				}
			})
	}
	
	public func asValue<T>(fallback: T? = nil) -> Observable<T>
		where E == ValueResult<T>
	{
		if let fallback = fallback {
			return self.map({ $0.value ?? fallback })
		}
		
		return self
			.materialize()
			.flatMap({ event -> Observable<T> in
				switch event {
				case .next(let valueResult):
					switch valueResult {
					case.Success(let value):
						return .just(value)
					case.Failure(let error):
						return .error(error)
					}
				case .error(let error):
					return .error(error)
				case .completed:
					return .empty()
				}
			})
	}
}




