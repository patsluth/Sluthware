//
//  ObservableType+Result.swift
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
    func get<Success, Failure>(onError: @escaping (Error) -> Void) -> Observable<Success>
        where Element == Swift.Result<Success, Failure>
	{
        return self
            .map({
                try $0.get()
            })
            .catchError({
                onError($0)
                return Observable.never()
            })
	}
}




