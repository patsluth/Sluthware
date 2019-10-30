//
//  PersistantCodableVariable.swift
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
public final class PersistantCodableVariable<T, RawType>: PersistantVariable<T>
	where T: Codable
{
	public required init(_ type: T.Type,
						 rawType: RawType.Type,
						 key: String = "",
						 userDefaults: UserDefaults = UserDefaults.standard)
	{
		super.init(type, key: "\(T.self)_\(key)", userDefaults: userDefaults)
	}
	
	override func readValue() -> E
	{
		var value: E = nil
		
		do {
			let rawValue = self.userDefaults.value(forKey: self.key)
			value = try Element.decode(rawValue)
		} catch {
			error.log()
		}
		
		sw.log(sender: self, "\(self.key) = \(value as Any)")
		
		return value
	}
	
	override func write(value: E)
	{
		do {
			let rawValue = try value?.encode(RawType.self)
			self.userDefaults.setValue(rawValue, forKey: self.key)
			sw.log(sender: self, "\(self.key) = \(value as Any)")
		} catch {
			error.log()
		}
	}
}






