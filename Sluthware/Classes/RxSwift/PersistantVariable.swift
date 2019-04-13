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
/// RawType is the value that E will be encoded/decoded to/from
public final class PersistantVariable<Element, RawType>: ObservableType
	where Element: Codable
{
	public typealias E = Element?
	
	
	
	private let key: String
	private let userDefaults: UserDefaults
	private let _relay: BehaviorRelay<E>
	
	public var value: E {
		return self._relay.value
	}
	
	
	
	
	
	public init(_ type: Element.Type,
				_ rawType: RawType.Type,
				_ key: String,
				_ userDefaults: UserDefaults = UserDefaults.standard)
	{
		self.key = key
		self.userDefaults = userDefaults
		self._relay = BehaviorRelay(value: nil)
		
		defer {
			self.accept(self.readValue())
		}
	}
	
	private func readValue() -> E
	{
		var value: E = nil
		
		do {
			let rawValue = self.userDefaults.value(forKey: self.key)
			value = try E.decode(rawValue)
		} catch {
			error.log()
		}
		
		printSW("Read \(self.key): \(value as Any)")
		
		return value
	}
	
	private func write(value: E)
	{
		do {
			let rawValue = try value?.encode(RawType.self)
			self.userDefaults.setValue(rawValue, forKey: self.key)
			printSW("Write \(self.key): \(value as Any)")
		} catch {
			error.log()
		}
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




