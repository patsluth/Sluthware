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
	public typealias ObservableElement = Swift.Result<T, Error>
	
	
	
	
	
	public func asSingle() -> Single<ObservableElement>
	{
		return self.asObservable().asSingle()
	}
	
	public func asObservable() -> Observable<ObservableElement>
	{
		let (promise, resolver) = Promise<T>.pending()
		
		self.done({
			guard promise.isPending else { return resolver.reject(PMKError.cancelled) }
			resolver.fulfill($0)
		}).catch({
			resolver.reject($0)
		})
		
		return Observable.create { observable in
			
			promise.done({
				observable.onNext(.success($0))
			}).catch({
				observable.onNext(.failure($0))
			})
			
			return Disposables.create {
			}
			
			}.do(onDispose: {
				if promise.isPending {
					resolver.reject(PMKError.cancelled)
				}
			})
	}
}





public extension ObservableType
{
	func asPromise() -> Promise<E>
	{
		return Promise { resolver in
			_ = self.take(1).asSingle()
				.subscribe(onSuccess: {
					resolver.fulfill($0)
				}, onError: {
					resolver.reject($0)
				})
		}
	}
	
	func asPromise() -> CancellablePromise<E>
	{
		return CancellablePromise { resolver in
			_ = self.take(1).asSingle()
				.subscribe(onSuccess: {
					resolver.fulfill($0)
				}, onError: {
					resolver.reject($0)
				})
		}
	}
}




