//
//  ObservableType+OnRunLoop.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-24.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa





extension ObservableType
{
	@available(iOS 10.0, *)
	public func onceThenOnRunLoop<T>(inModes modes: [RunLoop.Mode]) -> Observable<T>
		where E == T
	{
		return Observable<T>.create { observable in
			
			let first = self.take(1)
				.bind(onNext: { t in
//					print(#function, "\(t) Initial")
					observable.onNext(t)
				})
			
			let latest = self.skip(1)
				.flatMapLatest({ t in
					onRunPoopCompletable(inModes: modes)
						.andThen(Observable.just(t))
				})
				.bind(onNext: { t in
//					print(#function, "\(t) Updated")
					observable.onNext(t)
				})
			
			return Disposables.create() {
				first.dispose()
				latest.dispose()
			}
		}
	}
}





@available(iOS 10.0, *)
func onRunPoopCompletable(inModes modes: [RunLoop.Mode]) -> Completable
{
	return Completable.create { completable in
		
		RunLoop.current.perform(inModes: modes, block: {
			completable(CompletableEvent.completed)
		})
		
		return Disposables.create()
	}
}




