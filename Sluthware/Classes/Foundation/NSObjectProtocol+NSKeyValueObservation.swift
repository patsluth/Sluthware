//
//  NSObjectProtocol+NSKeyValueObservation.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-11-28.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import ObjectiveC





fileprivate var _keyValueObservations = Selector(("_keyValueObservations"))

public extension NSObjectProtocol where Self: NSObject
{
	var keyValueObservations: Set<NSKeyValueObservation> {
		get
		{
			if let keyValueObservations =
				objc_getAssociatedObject(self, &_keyValueObservations) as? Set<NSKeyValueObservation> {
				return keyValueObservations
			} else {
				self.keyValueObservations = Set<NSKeyValueObservation>()
				return self.keyValueObservations
			}
		}
		set
		{
			objc_setAssociatedObject(self,
									 &_keyValueObservations,
									 newValue,
									 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
}




