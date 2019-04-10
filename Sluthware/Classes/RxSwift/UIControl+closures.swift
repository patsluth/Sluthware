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
	func on(tap event: @escaping (Self) -> Void,
			disposedBy disposeBag: DisposeBag? = nil,
			throttle: TimeInterval = 0.0,
			debounce: TimeInterval = 0.0,
			scheduler: SchedulerType = MainScheduler.instance) -> Self
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
			event(self)
		})
		
		if let disposeBag = disposeBag {
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
				   event: @escaping (Self) -> Void,
				   disposedBy disposeBag: DisposeBag? = nil,
				   throttle: TimeInterval = 0.0,
				   debounce: TimeInterval = 0.0,
				   scheduler: SchedulerType = MainScheduler.instance) -> Self
	{
		var disposable = self.rx.controlEvent(controlEvent).on(event: { _ in
			event(self)
		})
		
		if let disposeBag = disposeBag {
			disposable.disposed(by: disposeBag)
		}
		
		return self
	}
}





public extension ControlEvent
{
	@discardableResult
	public func on(event: @escaping (E) -> Void,
				   throttle: TimeInterval = 0.0,
				   debounce: TimeInterval = 0.0,
				   scheduler: SchedulerType = MainScheduler.instance) -> Disposable
	{
		var observable = self
			.asObservable()
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
		
		return observable.bind(onNext: {
			event($0)
		})
	}
}




