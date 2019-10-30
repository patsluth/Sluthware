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
	typealias ResultType<T> = Swift.Result<T, Error>
	
	func asResult() -> Observable<ResultType<Element>>
	{
		return self
			.materialize()
			.flatMap({ event -> Observable<ResultType<Element>> in
				switch event {
					case .next(let value):		return .just(.success(value))
					case .error(let error):		return .just(.failure(error))
					case .completed:  			return .empty()
				}
			})
	}
	
	func unwrap<T>(fallback: T? = nil) -> Observable<T>
		where Element == ResultType<T>
	{
		if let fallback = fallback {
			return self.map({ (try? $0.get()) ?? fallback })
		}
		
		return self
			.materialize()
			.flatMap({ event -> Observable<T> in
				switch event {
					case .next(let result):
						do {
							return .just(try result.get())
						} catch {
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





