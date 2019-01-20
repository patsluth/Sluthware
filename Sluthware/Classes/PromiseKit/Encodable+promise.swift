//
//  Encodable+promise.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import PromiseKit





public extension Encodable
{
	func encodePromise<T>(_ type: T.Type) -> Promise<T>
	{
		return Promise { resolver in
			do {
				resolver.fulfill(try self.encode(type))
			} catch {
				resolver.reject(error)
			}
		}
	}
}




