//
//  PersistantVariable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa





/// A BehaviorRelay wrapper that saves and reads value from UserDefaults
public class PersistantVariable<T>: ObservableType
{
	public typealias E = T?
	
	
	
	let key: String
	let userDefaults: UserDefaults
	private let _relay: BehaviorRelay<E>
	
	public var value: E {
		return self._relay.value
	}
	
	
	
	
	
	public init(_ key: String,
				_ userDefaults: UserDefaults = UserDefaults.standard)
	{
		self.key = key
		self.userDefaults = userDefaults
		self._relay = BehaviorRelay(value: nil)
		
		defer {
			self.accept(self.readValue())
		}
	}
	
	func readValue() -> E
	{
		let value = self.userDefaults.value(forKey: self.key) as? T
		printSW(sender: self, "\(self.key) = \(value)")
		return value
	}
	
	func write(value: E)
	{
		self.userDefaults.setValue(value, forKey: self.key)
		printSW(sender: self, "\(self.key) = \(value)")
	}
	
	public func accept(_ event: E)
	{
		self._relay.accept(event)
		
		self.write(value: self.value)
	}
	
	// MARK: ObservableType
	
	public func subscribe<O>(_ observer: O) -> Disposable
		where O: ObserverType, O.E == E
	{
		return self._relay.subscribe(observer)
	}
	
	public func asObservable() -> Observable<E>
	{
		return self._relay.asObservable()
	}
}




