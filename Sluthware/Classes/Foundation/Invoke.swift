//
//  Invoke.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public final class Invoke
{
	public class func after(completion: @escaping (_ isComplete: UnsafeMutablePointer<Bool>) -> Void,
							_ block: @escaping () -> Void)
	{
		var isComplete = false
		withUnsafeMutablePointer(to: &isComplete) { isCompletePointer in
			
			DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
				
				repeat {
					completion(isCompletePointer)
				} while (isCompletePointer.pointee == false)
				
				DispatchQueue.main.async(execute: {
					block()
				})
			}
		}
	}
	
	@discardableResult
	public class func after(delay: TimeInterval,
							_ block: @escaping () -> Void) -> DispatchWorkItem
	{
		return Invoke.after(delay: delay, on: DispatchQueue.main, block)
	}
	
	@discardableResult
	public class func after(delay: TimeInterval,
							for qos: DispatchQoS.QoSClass,
							_ block: @escaping () -> Void) -> DispatchWorkItem
	{
		return Invoke.after(delay: delay, on: DispatchQueue.global(qos: qos), block)
	}
	
	@discardableResult
	fileprivate class func after(delay: TimeInterval,
								 on queue: DispatchQueue,
								 _ block: @escaping () -> Void) -> DispatchWorkItem
	{
		let task = DispatchWorkItem {
			block()
		}
		
		queue.asyncAfter(deadline: DispatchTime.now() + delay, execute: task)
		
		return task
	}
	
	@discardableResult
	public class func after2(delay: TimeInterval,
								 on queue: DispatchQueue,
								 _ block: @escaping (inout Bool) -> Void) -> DispatchWorkItem
	{
		var r = false
		
		let task = DispatchWorkItem {
			block(&r)
			if r == true {
				Invoke.after2(delay: delay, on: queue, block)
			}
		}
		
		queue.asyncAfter(deadline: DispatchTime.now() + delay, execute: task)
		
		return task
	}
}





