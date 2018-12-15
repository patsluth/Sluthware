//
//  Promise.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa

#if canImport(PromiseKit)
import PromiseKit





public extension Promise
{
	public func asSingle() -> Single<T>
	{
		return Single<T>.create { observable in
			
			self.done({
				observable(.success($0))
			}).catch({
				observable(.error($0))
			})
			
			return Disposables.create()
		}
	}
	
	public func asObservable() -> Observable<T>
	{
		return Observable<T>.create { observable in
			
			self.done({
				observable.onNext($0)
				observable.onCompleted()
			}).catch({
				observable.onError($0)
			})
			
			return Disposables.create()
		}
	}
}
#endif




