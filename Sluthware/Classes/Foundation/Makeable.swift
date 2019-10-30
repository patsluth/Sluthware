//
//  NSObjectProtocol+Makeable.swift
//  vytality-customer
//
//  Created by Pat Sluth on 2019-02-25.
//

import Foundation
#if os(iOS)
import UIKit
#endif





public protocol Makeable: NSObjectProtocol
{
	typealias MadeClosure = (Self) -> Void
	
	init()
}

extension NSObject: Makeable {  }

public extension Makeable
{
	@discardableResult
	static func make(_ block: MadeClosure? = nil) -> Self
	{
		let made = Self()
		
		defer { made.didMake(block) }
		
		return made
	}
	
	internal func didMake(_ block: MadeClosure? = nil)
	{
		#if os(iOS)
		
		let view = self as? UIView
		
		view?.translatesAutoresizingMaskIntoConstraints = false
		block?(self)
		view?.setNeedsUpdateConstraints()
		view?.setNeedsLayout()
		
		#endif
	}
}





#if os(iOS)

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

#endif




