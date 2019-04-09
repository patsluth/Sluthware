//
//  Reactive+onTap.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa





public extension Reactive
	where Base: UIButton
{
	public func onTap(throttle: RxTimeInterval = 0.25,
					  _ block: @escaping (Base) -> Void) -> Disposable
	{
		return self.tap
			.asDriver()
			.throttle(throttle)
			.debug()
			.drive(onNext: { [unowned base = self.base] in
				block(base)
			})
	}
	
	//	typealias Completion = (@escaping () -> Void) -> Void
	//	public func onTapDisable(until complete: @escaping Completion) -> Disposable
	//	{
	//		return self.tap
	//			.asDriver()
	//			.drive(onNext: { [unowned button = self.base] in
	//				button.isEnabled = false
	//				complete({
	//					button.isEnabled = true
	//				})
	//			})
	//	}
}





// TODO: Disable block
public extension ControlEvent
{
	public func on(throttle: RxTimeInterval = 0.25,
				   _ block: @escaping (PropertyType) -> Void) -> Disposable
	{
		return self
			.asDriver()
			.throttle(throttle)
			.debug()
			.drive(onNext: {
				block($0)
			})
	}
}





public extension Reactive
	where Base: UIBarButtonItem
{
	public func onTap(throttle: RxTimeInterval = 0.25,
					  _ block: @escaping (Base) -> Void) -> Disposable
	{
		return self.tap
			.asDriver()
			.throttle(throttle)
			.debug()
			.drive(onNext: { [unowned base = self.base] in
				block(base)
			})
	}
	
	//	public func onTapDisable(until complete: @escaping (@escaping () -> Void) -> Void) -> Disposable
	//	{
	//		return self.tap
	//			.asDriver()
	//			.drive(onNext: { [unowned button = self.base] in
	//				button.isEnabled = false
	//				complete({
	//					button.isEnabled = true
	//				})
	//			})
	//	}
}




