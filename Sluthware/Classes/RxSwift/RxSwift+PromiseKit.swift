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





///// A protocol for promise types that can be converted to RxSwift observables
//public protocol RxSwiftPromiseKitConvertible
//{
//	associatedtype T
//
//	func asObservable() -> Observable<Swift.Result<T, Error>>
//}
//
//
//
//
//
//public extension RxSwiftPromiseKitConvertible
//{
//	func asSingle() -> Single<Swift.Result<T, Error>>
//	{
//		return self.asObservable().asSingle()
//	}
//}





extension Promise: ObservableConvertibleType
{
	public typealias Element = Swift.Result<T, Error>
	
	public func asObservable() -> Observable<Element>
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
			}).finally({
				observable.onCompleted()
			})
			
			return Disposables.create(with: {
				if promise.isPending {
					resolver.reject(PMKError.cancelled)
				}
			})
		})
	}
}





extension CancellablePromise: ObservableConvertibleType
{
	public typealias Element = Swift.Result<T, Error>
	
	public func asObservable() -> Observable<Element>
	{
		return Observable.create({ observable in
			let context = self.done({
				observable.onNext(.success($0))
			}).catch({
				observable.onNext(.failure($0))
			}).finally({
				observable.onCompleted()
			})
			
			return Disposables.create(with: {
				if self.isPending {
					context.cancel()
				}
			})
		})
	}
}





public extension ObservableConvertibleType
{
	func asPromise() -> Promise<Element>
	{
		let (promise, resolver) = Promise<Element>.pending()
		
		_ = self.asObservable()
			.take(1)
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
	
	func asPromise() -> CancellablePromise<Element>
	{
		let (promise, resolver) = CancellablePromise<Element>.pending()
		
		_ = self.asObservable()
			.take(1)
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




