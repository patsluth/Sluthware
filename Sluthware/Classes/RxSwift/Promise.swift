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
	public typealias ObservableElement = Swift.Result<T, Error>
	
	public func asSingle() -> Single<ObservableElement>
	{
		return Single.create { observable in
			
			self.done({
				observable(.success(.success($0)))
			}).catch({
				observable(.success(.failure($0)))
			})
			
			return Disposables.create {
				self.cauterize()
			}
		}
	}
	
	public func asObservable() -> Observable<ObservableElement>
	{
		return Observable.create { observable in
			
			self.done({
				observable.onNext(.success($0))
			}).catch({
				observable.onNext(.failure($0))
			}).finally({
				observable.onCompleted()
			})
			
			return Disposables.create {
				self.cauterize()
			}
		}
	}
}
#endif




