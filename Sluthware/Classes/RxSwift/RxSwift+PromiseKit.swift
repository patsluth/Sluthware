//
//  RxSwift+PromiseKit.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import PromiseKit
import CancelForPromiseKit





public extension Promise
{
	func asSingle() -> Single<Swift.Result<T, Error>>
	{
		return self.asObservable().asSingle()
	}
	
	func asObservable() -> Observable<Swift.Result<T, Error>>
	{
		let (promise, resolver) = Promise<T>.pending()
		
		self.done({
			if promise.isPending && !promise.isRejected {
				resolver.fulfill($0)
			} else {
				resolver.reject(PMKError.cancelled)
			}
		}).catch({
			resolver.reject($0)
		})
		
		return Observable.create({ observable in
			promise.done({
				observable.onNext(.success($0))
			}).catch({
				observable.onNext(.failure($0))
			})
			
			return Disposables.create(with: {
				if promise.isPending {
					resolver.reject(PMKError.cancelled)
				}
			})
		})
	}
}





public extension CancellablePromise
{
	func asSingle() -> Single<Swift.Result<T, Error>>
	{
		return self.asObservable().asSingle()
	}
	
	func asObservable() -> Observable<Swift.Result<T, Error>>
	{
		return Observable.create({ observable in
			let context = self.done({
				observable.onNext(.success($0))
			}).catch({
				observable.onNext(.failure($0))
			})
			
			return Disposables.create(with: {
				if self.isPending {
					context.cancel()
				}
			})
		})
	}
}





public extension ObservableType
{
	func asPromise() -> Promise<E>
	{
		let (promise, resolver) = Promise<E>.pending()
		
		_ = self.take(1)
			.subscribe(onNext: {
				resolver.fulfill($0)
			}, onError: {
				resolver.reject($0)
			}, onDisposed: {
				if !promise.isFulfilled {
					resolver.reject(PMKError.cancelled)
				}
			})
		
		return promise
	}
	
	func asCancellablePromise() -> CancellablePromise<E>
	{
		let (promise, resolver) = CancellablePromise<E>.pending()
		
		_ = self.take(1)
			.subscribe(onNext: {
				resolver.fulfill($0)
			}, onError: {
				resolver.reject($0)
			}, onDisposed: {
				if !promise.isFulfilled {
					promise.cancel()
				}
			})
		
		return promise
	}
}




