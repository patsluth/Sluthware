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
        
		defer {
			block?(made)
		}
        
        return made
    }
}

#if os(iOS)

public extension Makeable
	where Self: UIView
{
	@discardableResult
	static func make(_ block: MadeClosure? = nil) -> Self
	{
		let made: Self!
		if let nib = (Self.self as? NibProvider.Type)?.nib,
			let nibView = nib.instantiate(withOwner: nil, options: nil).first as? Self {
			made = nibView
		} else {
			made = Self()
			made.translatesAutoresizingMaskIntoConstraints = false
		}
		
		defer {
			made.setNeedsUpdateConstraints()
			made.setNeedsLayout()
			block?(made)
		}
		
		return made
	}
}

public extension Makeable
    where Self: UIButton
{
    @discardableResult
    static func make(type: UIButton.ButtonType, _ block: MadeClosure? = nil) -> Self
    {
        let made = Self(type: type)
		made.translatesAutoresizingMaskIntoConstraints = false
        
		defer {
			block?(made)
		}
        
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
		made.translatesAutoresizingMaskIntoConstraints = false
        
		defer {
			block?(made)
		}
        
        return made
    }
}

#endif




