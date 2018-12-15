//
//  UIElementHierarchy.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit





public extension UIView
{
	public var ancestorViewController: UIViewController?
	{
		var responder: UIResponder? = self
		
		repeat {
			responder = responder?.next
			if let viewController = responder as? UIViewController {
				return viewController
			}
		} while responder != nil
		
		return nil
	}
	
	public func recurseAncestors(_ block: (UIView) -> Bool)
	{
		let stop = block(self)
		
		guard !stop else { return }
		
		if let superview = self.superview {
			superview.recurseAncestors(block)
		}
	}
	
	public func recurseDecendents(_ block: (UIView) -> Bool)
	{
		let stop = block(self)
		
		guard !stop else { return }
		
		for subview in self.subviews {
			subview.recurseAncestors(block)
		}
	}
}





public extension UIViewController
{
	public func recurseAncestors(_ block: (UIViewController) -> Bool)
	{
		let stop = block(self)
		
		guard !stop else { return }
		
		if let viewController = self.parent ?? self.presentingViewController {
			viewController.recurseAncestors(block)
		}
	}
	
	public func recurseDecendents(_ block: (UIViewController) -> Bool)
	{
		let stop = block(self)
		
		guard !stop else { return }
		
		if let viewController = self.presentedViewController {
			viewController.recurseDecendents(block)
		}
		
		for viewController in self.children {
			viewController.recurseDecendents(block)
		}
	}
}
