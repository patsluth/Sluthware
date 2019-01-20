//
//  Decodable+promise.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import PromiseKit





public extension Decodable
{
	static func decodePromise<T>(_ value: T) -> Promise<Self>
	{
		return Promise { resolver in
			do {
				resolver.fulfill(try Self.decode(value))
			} catch {
				resolver.reject(error)
			}
		}
	}
}




