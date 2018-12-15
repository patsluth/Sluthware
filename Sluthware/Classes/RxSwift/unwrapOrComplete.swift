//
//  unwrapOrComplete.swift
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
	public func unwrapOrComplete<T>() -> Observable<T>
		where E == T?
	{
		return Observable<T>.create { observable in
			
			_ = self.take(1)
				.bind(onNext: { t in
					if let t = t {
						observable.onNext(t)
					} else {
						observable.onCompleted()
					}
				})
			
			return Disposables.create {
			}
		}
	}
}




