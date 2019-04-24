//
//  ObservableType+or.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa




public extension ObservableType
{
//	public static func or<A, B>(_ a: Observable<A>, _ b: Observable<B>) -> Observable<ExclusivePair<A, B>>
//	{
//		return Observable<ExclusivePair<A, B>>.create({ observable in
//
//			let disposableA = a.bind(onNext: {
//				observable.onNext(.A($0))
//			})
//
//			let disposableB = b.bind(onNext: {
//				observable.onNext(.B($0))
//			})
//
//			return Disposables.create([disposableA, disposableB])
//		})
//	}
	
	public func or<B>(_ b: Observable<B>) -> Observable<ExclusivePair<E, B>>
	{
		return Observable.create({ observable in
			
			let disposableA = self.bind(onNext: {
				observable.onNext(.A($0))
			})
			
			let disposableB = b.bind(onNext: {
				observable.onNext(.B($0))
			})
			
			return Disposables.create([disposableA, disposableB])
		})
	}
}




