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





// Wrapper to call disposed(by:) and map to self
public struct DisposableReturnValue<T>
{
	let value: T
	let disposable: Disposable
	
	
	
	
	
	@discardableResult
	public func dispose() -> T
	{
		self.disposable.dispose()
		return self.value
	}
	
	@discardableResult
	public func disposed(by bag: DisposeBag?) -> T
	{
		if let bag = bag {
			self.disposable.disposed(by: bag)
		}
		return self.value
	}
}





public extension NSObjectProtocol
	where Self: UIControl
{
	@discardableResult
	func on(_ controlEvent: UIControl.Event,
			_ event: @escaping (Self) -> Void,
			throttle: RxTimeInterval = .never,
			debounce: RxTimeInterval = .never,
			debug: Bool = false) -> DisposableReturnValue<Self>
	{
		let _event = { [unowned self] in
			event(self)
		}
		
		let disposable = self.rx.controlEvent(controlEvent)
			.on(_event,
				takeUntil: self.rx.deallocated,
				throttle: throttle,
				debounce: debounce,
				debug: debug)
		
		
		return DisposableReturnValue(value: self, disposable: disposable)
	}
	
	@discardableResult
	func on(_ controlEvent: UIControl.Event,
			_ event: @escaping (Self) -> Void,
			throttle: RxTimeInterval = .never,
			debounce: RxTimeInterval = .never,
			debug: Bool = false,
			disposedBy disposeBag: DisposeBag? = nil) -> Self
	{
		return self.on(controlEvent,
					   event,
					   throttle: throttle,
					   debounce: debounce,
					   debug: debug).disposed(by: disposeBag)
	}
	
	
	
	@discardableResult
	func on(tap event: @escaping (Self) -> Void,
			throttle: RxTimeInterval = .never,
			debounce: RxTimeInterval = .never,
			debug: Bool = false) -> DisposableReturnValue<Self>
	{
		return self.on(.touchUpInside,
					   event,
					   throttle: throttle,
					   debounce: debounce,
					   debug: debug)
	}
	
	@discardableResult
	func on(tap event: @escaping (Self) -> Void,
			throttle: RxTimeInterval = .never,
			debounce: RxTimeInterval = .never,
			debug: Bool = false,
			disposedBy disposeBag: DisposeBag? = nil) -> Self
	{
		return self.on(tap: event,
					   throttle: throttle,
					   debounce: debounce,
					   debug: debug).disposed(by: disposeBag)
	}
	
	
	
	@discardableResult
	func on<T>(_ controlPropertyKeyPath: KeyPath<Reactive<Self>, ControlProperty<T>>,
			   _ event: @escaping (Self, T) -> Void,
			   throttle: RxTimeInterval = .never,
			   debounce: RxTimeInterval = .never,
			   debug: Bool = false) -> DisposableReturnValue<Self>
	{
		let _event = { [unowned self] (t: T) in
			event(self, t)
		}
		let controlProperty = self.rx[keyPath: controlPropertyKeyPath]
		let disposable = controlProperty
			.on(_event,
				takeUntil: self.rx.deallocated,
				throttle: throttle,
				debounce: debounce,
				debug: debug)
		
		return DisposableReturnValue(value: self, disposable: disposable)
	}
	
	func on<T>(_ controlPropertyKeyPath: KeyPath<Reactive<Self>, ControlProperty<T>>,
			   _ event: @escaping (Self, T) -> Void,
			   throttle: RxTimeInterval = .never,
			   debounce: RxTimeInterval = .never,
			   debug: Bool = false,
			   disposedBy disposeBag: DisposeBag? = nil) -> Self
	{
		return self.on(controlPropertyKeyPath,
					   event,
					   throttle: throttle,
					   debounce: debounce,
					   debug: debug).disposed(by: disposeBag)
	}
}





public extension NSObjectProtocol
	where Self: UIBarButtonItem
{
	@discardableResult
	func on(tap event: @escaping (Self) -> Void,
			throttle: RxTimeInterval = .never,
			debounce: RxTimeInterval = .never,
			debug: Bool = false) -> DisposableReturnValue<Self>
	{
		let _event = { [unowned self] in
			event(self)
		}
		
		let disposable = self.rx.tap
			.on(_event,
				takeUntil: self.rx.deallocated,
				throttle: throttle,
				debounce: debounce,
				debug: debug)
		
		return DisposableReturnValue(value: self, disposable: disposable)
	}
	
	@discardableResult
	func on(tap event: @escaping (Self) -> Void,
			throttle: RxTimeInterval = .never,
			debounce: RxTimeInterval = .never,
			debug: Bool = false,
			disposedBy disposeBag: DisposeBag? = nil) -> Self
	{
		return self.on(tap: event,
					   throttle: throttle,
					   debounce: debounce,
					   debug: debug).disposed(by: disposeBag)
	}
}





internal extension ControlEvent
{
	@discardableResult
	func on(_ event: @escaping (Element) -> Void,
			takeUntil: Observable<Void>,
			throttle: RxTimeInterval = .never,
			debounce: RxTimeInterval = .never,
			debug: Bool = false) -> Disposable
	{
		var observable = self
			.asObservable()
			.takeUntil(takeUntil)
		
		#if DEBUG
		if debug {
			observable = observable.debug()
		}
		#endif
		
		var driver = observable
			.asDriver(onErrorRecover: { _ in
				Driver<Element>.empty()
			})
		
		if throttle != .never {
			driver = driver.throttle(RxTimeInterval.seconds(1))
		}
		
		if debounce != .never {
			driver = driver.debounce(debounce)
		}
		
		return driver.drive(onNext: {
			event($0)
		})
	}
}





internal extension ControlProperty
{
	@discardableResult
	func on(_ event: @escaping (E) -> Void,
			takeUntil: Observable<Void>,
			throttle: RxTimeInterval = .never,
			debounce: RxTimeInterval = .never,
			debug: Bool = false) -> Disposable
	{
		var observable = self
			.asObservable()
			.takeUntil(takeUntil)
		
		#if DEBUG
		if debug {
			observable = observable.debug()
		}
		#endif
		
		var driver = observable
			.asDriver(onErrorRecover: { _ in
				Driver<Element>.empty()
			})
		
		if throttle != .never {
			driver = driver.throttle(throttle)
		}
		
		if debounce != .never {
			driver = driver.debounce(debounce)
		}
		
		return driver.drive(onNext: {
			event($0)
		})
	}
}





