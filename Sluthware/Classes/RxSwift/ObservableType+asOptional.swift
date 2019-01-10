//
//  ObservableType+asOptional.swift
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
	public func asOptional(catchError: @escaping (Error) throws -> Observable<E?>) -> Observable<E?>
	{
		return self
			.materialize()
			.flatMap({ event -> Observable<E?> in
				switch event {
				case .next(let value):
					return .just(value)
				case .error(let error):
					do {
						return try catchError(error)
					} catch {
						return .error(error)
					}
				case .completed:
					return .empty()
				}
			})
	}
}




