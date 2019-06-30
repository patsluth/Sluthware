//
//  Promise+attempt.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import PromiseKit





public extension Promise
{
    static func wrap(_ block: () throws -> T) -> Promise<T>
    {
        return Promise<T>(resolver: { resolver in
            do {
                resolver.fulfill(try block())
            } catch {
                resolver.reject(error)
            }
        })
    }
}




