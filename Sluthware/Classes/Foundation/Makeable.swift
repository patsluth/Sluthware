//
//  NSObjectProtocol+Makeable.swift
//  vytality-customer
//
//  Created by Pat Sluth on 2019-02-25.
//

import Foundation
import UIKit





public protocol Makeable: NSObjectProtocol
{
	typealias MadeClosure = (Self) -> Void
}

extension NSObject: Makeable {  }

public extension Makeable
	where Self: NSObject
{
	@discardableResult
	static func make(_ block: MadeClosure? = nil) -> Self
	{
		let made = Self()
		
		defer { made.didMake(block) }
		
		return made
	}
	
	@discardableResult
	internal func didMake(_ block: MadeClosure? = nil)
	{
		let view = self as? UIView
		
		view?.translatesAutoresizingMaskIntoConstraints = false
		block?(self)
		view?.setNeedsUpdateConstraints()
		view?.setNeedsLayout()
	}
}





public extension Makeable
	where Self: UIButton
{
	@discardableResult
	static func make(type: UIButton.ButtonType, _ block: MadeClosure? = nil) -> Self
	{
		let made = Self(type: type)
		
		defer { made.didMake(block) }
		
		return made
	}
}





public extension Makeable
	where Self: UICollectionView
{
	@discardableResult
	static func make<T>(layout: T, _ block: MadeClosure? = nil) -> Self
		where T: UICollectionViewLayout
	{
		let made = Self(frame: .zero, collectionViewLayout: layout)
		
		defer { made.didMake(block) }
		
		return made
	}
}




