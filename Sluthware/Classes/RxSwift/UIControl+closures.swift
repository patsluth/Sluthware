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
public struct ControlObservableWrapper<Base, Element>
	where Base: AnyObject & ReactiveCompatible
{
	fileprivate let base: Base
	fileprivate var observable: Observable<Element>
	
	
	
	
	
	fileprivate init(_ base: Base, _ controlEvent: ControlEvent<Element>)
	{
		self.base = base
		self.observable = controlEvent
			.asObservable()
			.takeUntil(self.base.rx.deallocated)
	}
	
	fileprivate init(_ base: Base, _ controlProperty: ControlProperty<Element>)
	{
		self.base = base
		self.observable = controlProperty
			.asObservable()
			.takeUntil(self.base.rx.deallocated)
	}
	
	fileprivate init(_ base: Base, _ observable: Observable<Element>)
	{
		self.base = base
		self.observable = observable
	}
	
	fileprivate func finalize() -> Driver<Element>
	{
		return self.observable
			//			.debug()
			.asDriver(onErrorRecover: { _ in
				.empty()
			})
	}
	
	/// Edit the current observable, to apply debounce or throttle for example
	public func prepare(changes: (Observable<Element>) -> Observable<Element>) -> ControlObservableWrapper<Base, Element>
	{
		return ControlObservableWrapper(self.base, changes(self.observable))
	}
	
	public func map<O>(_ block: @escaping (Base, Element) -> O) -> ControlObservableWrapper<Base, O.Element>
		where O: ObservableConvertibleType
	{
		let observable = self.observable
			.flatMapLatest({ [unowned base = self.base] in
				block(base, $0)
			})
		
		return ControlObservableWrapper<Base, O.Element>(self.base, observable)
	}
	
	public func map<O>(_ block: @escaping (Base) -> O) -> ControlObservableWrapper<Base, O.Element>
		where O: ObservableConvertibleType
	{
		let observable = self.observable
			.flatMapLatest({ [unowned base = self.base] _ in
				block(base)
			})
		
		return ControlObservableWrapper<Base, O.Element>(self.base, observable)
	}
	
	public func on(_ event: @escaping (Base, Element) -> Void) -> DisposableWrapper<Base>
	{
		let disposable = self.finalize()
			.drive(onNext: { [unowned base = self.base] in
				event(base, $0)
			})
		
		return DisposableWrapper(self.base, disposable)
	}
	
	public func on(_ event: @escaping (Base) -> Void) -> DisposableWrapper<Base>
	{
		let disposable = self.finalize()
			.drive(onNext: { [unowned base = self.base] _ in
				event(base)
			})
		
		return DisposableWrapper(self.base, disposable)
	}
}





public struct DisposableWrapper<Value>
{
	private let value: Value
	private let disposable: Disposable
	
	
	
	
	
	fileprivate init(_ value: Value, _ disposable: Disposable)
	{
		self.value = value
		self.disposable = disposable
	}
	
	@discardableResult
	public func dispose() -> Value
	{
		self.disposable.dispose()
		
		return self.value
	}
	
	@discardableResult
	public func disposed(by disposedBag: DisposeBag?) -> Value
	{
		if let disposedBag = disposedBag {
			self.disposable.disposed(by: disposedBag)
		}
		return self.value
	}
}





public extension NSObjectProtocol
	where Self: UIControl
{
	@discardableResult
	func on(_ controlEvent: UIControl.Event) -> ControlObservableWrapper<Self, Void>
	{
		let controlEvent = self.rx.controlEvent(controlEvent)
		return ControlObservableWrapper(self, controlEvent)
	}
	
	@discardableResult
	func on(_ controlEvent: UIControl.Event,
			_ event: @escaping (Self) -> Void) -> DisposableWrapper<Self>
	{
		return self.on(controlEvent).on(event)
	}
	
	
	
	@discardableResult
	func on<T>(controlProperty keyPath: KeyPath<Reactive<Self>, ControlProperty<T>>) -> ControlObservableWrapper<Self, T>
	{
		let controlProperty = self.rx[keyPath: keyPath]
		return ControlObservableWrapper(self, controlProperty)
	}
	
	func on<T>(controlProperty keyPath: KeyPath<Reactive<Self>, ControlProperty<T>>,
			   _ event: @escaping (Self, T) -> Void) -> DisposableWrapper<Self>
	{
		return self.on(controlProperty: keyPath).on(event)
	}
	
	
	
	@discardableResult
	func onTap() -> ControlObservableWrapper<Self, Void>
	{
		return self.on(.touchUpInside)
	}
	
	@discardableResult
	func onTap(_ event: @escaping (Self) -> Void) -> DisposableWrapper<Self>
	{
		return self.onTap().on(event)
	}
}





public extension NSObjectProtocol
	where Self: UIBarButtonItem
{
	@discardableResult
	func onTap() -> ControlObservableWrapper<Self, Void>
	{
		//		if let control = self.customView as? UIControl {
		//			let observable = control.onTap().map({ [unowned self] _ in
		//				Observable.just(self)
		//			})
		//			return ControlObservableWrapper(self, observable)
		//		}
		
		return ControlObservableWrapper(self, self.rx.tap)
	}
	
	@discardableResult
	func onTap(_ event: @escaping (Self) -> Void) -> DisposableWrapper<Self>
	{
		return self.onTap().on(event)
	}
}





