//
//  UIControl+closures.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa





public protocol TappableControl: NSObject
{
	var tap: RxCocoa.ControlEvent<()> { get }
}

extension UIButton: TappableControl
{
	public var tap: ControlEvent<()> {
		return self.rx.tap
	}
}

extension UIBarButtonItem: TappableControl
{
	public var tap: ControlEvent<()> {
		return self.rx.tap
	}
}





public extension TappableControl
{
	@discardableResult
	func onTap(throttle: TimeInterval = 0.0,
			   debounce: TimeInterval = 0.0,
			   scheduler: SchedulerType = MainScheduler.instance,
			   _ block: @escaping (Self) -> Void,
			   disposedBy: DisposeBag? = nil) -> Self
	{
		var observable = self.tap
			.asObservable()
			.takeUntil(self.rx.deallocated)
			.observeOn(MainScheduler.instance)
		
		if throttle > 0.0 {
			observable = observable.throttle(throttle, scheduler: scheduler)
		}
		if debounce > 0.0 {
			observable = observable.debounce(debounce, scheduler: scheduler)
		}
		
		#if DEBUG
		observable = observable.debug()
		#endif
		
		let disposable = observable.bind(onNext: { [unowned self] in
			block(self)
		})
		
		if let disposeBag = disposedBy {
			disposable.disposed(by: disposeBag)
		}
		
		return self
	}
}





public extension NSObjectProtocol
	where Self: UIControl
{
	@discardableResult
	public func on(controlEvent: UIControl.Event,
				   throttle: TimeInterval = 0.0,
				   debounce: TimeInterval = 0.0,
				   scheduler: SchedulerType = MainScheduler.instance,
				   _ block: @escaping (Self) -> Void,
				   disposedBy: DisposeBag? = nil) -> Self
	{
		var observable = self.rx.controlEvent(controlEvent)
			.asObservable()
			.takeUntil(self.rx.deallocated)
			.observeOn(scheduler)
		
		if throttle > 0.0 {
			observable = observable.throttle(throttle, scheduler: scheduler)
		}
		if debounce > 0.0 {
			observable = observable.debounce(debounce, scheduler: scheduler)
		}
		
		#if DEBUG
		observable = observable.debug()
		#endif
		
		let disposable = observable.bind(onNext: { [unowned self] in
			block(self)
		})
		
		if let disposeBag = disposedBy {
			disposable.disposed(by: disposeBag)
		}
		
		return self
	}
}




