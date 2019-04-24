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




// TODO: Remove
public extension ObservableType
{
	public func and<B>(_ b: Observable<B>) -> Observable<Pair<E, B>>
	{
		return Observable.combineLatest(self, b, resultSelector: {
			Pair($0, $1)
		})
//		return Observable.create({ observable in
//
//			var _a: E? = nil
//			var _b: B? = nil
//
//			let disposableA = self.bind(onNext: {
//				_a = $0
//				if let pair = Pair(_a, _b) {
//					observable.onNext(pair)
//				}
//			})
//
//			let disposableB = b.bind(onNext: {
//				_b = $0
//				if let pair = Pair(_a, _b) {
//					observable.onNext(pair)
//				}
//			})
//
//			return Disposables.create([disposableA, disposableB])
//		})
	}
}




