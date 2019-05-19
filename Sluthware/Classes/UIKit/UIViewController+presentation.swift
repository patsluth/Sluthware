//
//  UIViewController+presentation.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import UIKit




public extension NSObjectProtocol
	where Self: UIViewController
{
	@available(iOS 5.0, *)
	@discardableResult
	func present(from vc: UIViewController) -> Self
	{
		return self.present(from: vc, animated: true, { _ in })
	}
	
	@available(iOS 5.0, *)
	@discardableResult
	func present(from vc: UIViewController,
				 _ completion: @escaping (Self) -> Void) -> Self
	{
		return self.present(from: vc, animated: true, completion)
	}
	
	@available(iOS 5.0, *)
	@discardableResult
	func present(from vc: UIViewController,
				 animated: Bool,
				 _ completion: @escaping (Self) -> Void) -> Self
	{
		if let presentedVC = vc.presentedViewController {
			if type(of: presentedVC) == type(of: self) {
				// continue
			} else {
				self.present(from: presentedVC, animated: animated, completion)
			}
			
			return self
		}
		
		vc.present(self, animated: animated, completion: {
			completion(self)
		})
		
		return self
	}
	
	@available(iOS 8.0, *)
	@discardableResult
	func show(from vc: UIViewController, sender: Any? = nil) -> Self
	{
		if let nc = vc.navigationController, vc !== nc.viewControllers.last {
			return self
		}
		
		vc.show(self, sender: sender)
		
		return self
	}
	
	@available(iOS 8.0, *)
	@discardableResult
	func showDetail(from vc: UIViewController, sender: Any? = nil) -> Self
	{
		vc.showDetailViewController(self, sender: sender)
		
		return self
	}
	
	@available(iOS 5.0, *)
	func dismiss(animated: Bool = true, _ completion: (() -> Void)? = nil)
	{
		self.dismiss(animated: animated, completion: completion)
	}
}




