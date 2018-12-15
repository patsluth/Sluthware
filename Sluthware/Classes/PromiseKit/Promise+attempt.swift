//
//  Promise+attempt.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import PromiseKit





public func attempt<T>(times: Int,
					   retryIn: DispatchTimeInterval,
					   _ closure: @escaping () -> Promise<T>) -> Promise<T>
{
	var attempts = 0
	
	func attemptInternal() -> Promise<T>
	{
		attempts += 1
		return closure().recover({ error -> Promise<T> in
			guard attempts < times else { throw error }
			return after(retryIn).then({ _ -> Promise<T> in
				attemptInternal()
			})
		})
	}
	
	return attemptInternal()
}





public func attempt<T, V>(times: Int,
						  retryWhen: Guarantee<V>,
						  _ closure: @escaping () -> Promise<T>) -> Promise<T>
{
	var attempts = 0
	
	func attemptInternal() -> Promise<T>
	{
		attempts += 1
		return closure().recover({ error -> Promise<T> in
			guard attempts < times else { throw error }
			return retryWhen.then({ _ -> Promise<T> in
				attemptInternal()
			})
		})
	}
	
	return attemptInternal()
}






