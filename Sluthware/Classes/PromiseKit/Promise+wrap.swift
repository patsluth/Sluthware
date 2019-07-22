//
//  Promise+attempt.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import PromiseKit





public func promise_wrap<T>(_ block: () throws -> T) -> Promise<T>
{
	return Promise<T>(resolver: { resolver in
		do {
			resolver.fulfill(try block())
		} catch {
			resolver.reject(error)
		}
	})
}

public func promise_wrap<T>(_ block: () -> T) -> Guarantee<T>
{
	return Guarantee<T>(resolver: { resolver in
		resolver(block())
	})
}

//public func promise_wrap<T>(_ block: () throws -> T) -> CancellablePromise<T>
//	where T: CancellableTask
//{
//	return CancellablePromise<T>(resolver: { resolver in
//		do {
//			resolver.fulfill(try block())
//		} catch {
//			resolver.reject(error)
//		}
//	})
//}
//
//public func promise_wrap<T>(_ block: () -> T) -> CancellableGuarantee<T>
//	where T: CancellableTask
//{
//	return CancellableGuarantee<T>(resolver: { resolver in
//		resolver(block())
//	})
//}

//func testCancellable<T>(_ t: T) -> DispatchWorkItem
//{
//	let task = DispatchWorkItem(qos: .background, flags: .enforceQoS, block: {
//		Thread.sleep(forTimeInterval: 3)
//		sw.log(t)
//	})
//
//	DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
//		.async(execute: task)
//
//	return task
//}




