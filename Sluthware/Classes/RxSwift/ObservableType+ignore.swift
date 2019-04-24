//
//  ObservableType+ignore.swift
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
	public func ignore<O>(until otherObservable: O) -> Observable<E>
		where O: ObservableType
	{
		return otherObservable.flatMapLatest({ _ in
			self
		})
//		return Observable.create({ observable in
//
//			let disposable = otherObservable.flatMapLatest({
//				self
//			})
////			let disposableA = self.bind(onNext: {
////				observable.onNext(.A($0))
////			})
////
////			let disposableB = b.bind(onNext: {
////				observable.onNext(.B($0))
////			})
//
//			return Disposables.create([disposable])
//		})
	}
}




