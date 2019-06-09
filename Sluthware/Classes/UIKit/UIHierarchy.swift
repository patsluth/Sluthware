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
	var ancestorViewController: UIViewController?
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
	
	func recurseAncestors(includingSelf: Bool = true,
								 _ block: (UIView) -> Void)
	{
		self.recurseAncestors(includingSelf: includingSelf, { view, stop in
			block(view)
		})
	}
	
	func recurseAncestors(includingSelf: Bool = true,
								 _ block: (UIView, inout Bool) -> Void)
	{
		var stop = false
		if includingSelf {
			block(self, &stop)
		}
		
		guard !stop else { return }
		
		if let superview = self.superview {
			superview.recurseAncestors(block)
		}
	}
	
	func recurseDecendents(includingSelf: Bool = true,
								  _ block: (UIView) -> Void)
	{
		self.recurseDecendents(includingSelf: includingSelf, { view, stop in
			block(view)
		})
	}
	
	func recurseDecendents(includingSelf: Bool = true,
								  _ block: (UIView, inout Bool) -> Void)
	{
		var stop = false
		if includingSelf {
			block(self, &stop)
		}
		
		guard !stop else { return }
		
		for subview in self.subviews {
			subview.recurseDecendents(block)
		}
	}
}





public extension UIViewController
{
	func recurseAncestors(includingSelf: Bool = true,
								 _ block: (UIViewController) -> Void)
	{
		self.recurseAncestors(includingSelf: includingSelf, { viewController, stop in
			block(viewController)
		})
	}
	
	func recurseAncestors(includingSelf: Bool = true,
								 _ block: (UIViewController, inout Bool) -> Void)
	{
		var stop = false
		if includingSelf {
			block(self, &stop)
		}
		
		guard !stop else { return }
		
		if let viewController = self.parent {
			viewController.recurseAncestors(block)
		}
		
		if let viewController = self.presentingViewController {
			viewController.recurseAncestors(block)
		}
	}
	
	func recurseDecendents(includingSelf: Bool = true,
								  _ block: (UIViewController) -> Void)
	{
		self.recurseDecendents(includingSelf: includingSelf, { viewController, stop in
			block(viewController)
		})
	}
	
	func recurseDecendents(includingSelf: Bool = true,
								  _ block: (UIViewController, inout Bool) -> Void)
	{
		var stop = false
		if includingSelf {
			block(self, &stop)
		}
		
		guard !stop else { return }
		
		if let viewController = self.presentedViewController {
			viewController.recurseDecendents(block)
		}
		
		for viewController in self.children {
			viewController.recurseDecendents(block)
		}
	}
}
