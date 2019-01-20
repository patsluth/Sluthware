//
//  HTTPSCallable+promise.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import Firebase
import FirebaseFunctions
import PromiseKit





public extension HTTPSCallable
{
	func callPromise(_ data: Any? = nil) -> Promise<Any>
	{
		return Promise { resolver in
			self.call(data, completion: { result, error in
				if let result = result {
					resolver.fulfill(result.data)
				} else if let error = error {
					resolver.reject(error)
				}
			})
		}
	}
}




