//
//  NSObjectProtocol+Makeable.swift
//  vytality-customer
//
//  Created by Pat Sluth on 2019-02-25.
//

import Foundation
import UIKit





public protocol Makeable: NSObjectProtocol { }

extension NSObject: Makeable { }

public extension Makeable
	where Self: NSObject
{
	@discardableResult
	static func make(_ block: ((Self) -> Void)? = nil) -> Self
	{
		let object = Self()
		let view = object as? UIView
		
		defer {
			view?.translatesAutoresizingMaskIntoConstraints = false
			block?(object)
			view?.setNeedsUpdateConstraints()
			view?.setNeedsLayout()
		}
		
		return object
	}
}




