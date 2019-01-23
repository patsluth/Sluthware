//
//  UIHierarchy.swift
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
	
	public func recurseAncestors(_ block: (UIView) -> Void)
	{
		self.recurseAncestors { view, stop in
			block(view)
		}
	}
	
	public func recurseAncestors(_ block: (UIView, inout Bool) -> Void)
	{
		var stop = false
		block(self, &stop)
		
		guard !stop else { return }
		
		if let superview = self.superview {
			superview.recurseAncestors(block)
		}
	}
	
	public func recurseDecendents(_ block: (UIView) -> Void)
	{
		self.recurseDecendents { view, stop in
			block(view)
		}
	}
	
	public func recurseDecendents(_ block: (UIView, inout Bool) -> Void)
	{
		var stop = false
		block(self, &stop)
		
		guard !stop else { return }
		
		for subview in self.subviews {
			subview.recurseAncestors(block)
		}
	}
}





public extension UIViewController
{
	public func recurseAncestors(_ block: (UIViewController) -> Void)
	{
		self.recurseAncestors { viewController, stop in
			block(viewController)
		}
	}
	
	public func recurseAncestors(_ block: (UIViewController, inout Bool) -> Void)
	{
		var stop = false
		block(self, &stop)
		
		guard !stop else { return }
		
		if let viewController = self.parent ?? self.presentingViewController {
			viewController.recurseAncestors(block)
		}
	}
	
	public func recurseDecendents(_ block: (UIViewController) -> Void)
	{
		self.recurseDecendents { viewController, stop in
			block(viewController)
		}
	}
	
	public func recurseDecendents(_ block: (UIViewController, inout Bool) -> Void)
	{
		var stop = false
		block(self, &stop)
		
		guard !stop else { return }
		
		if let viewController = self.presentedViewController {
			viewController.recurseDecendents(block)
		}
		
		for viewController in self.children {
			viewController.recurseDecendents(block)
		}
	}
}
