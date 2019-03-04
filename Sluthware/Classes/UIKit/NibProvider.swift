//
//  ModelView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit





public protocol NibProvider
{
	static var nib: UINib { get }
}





extension NibProvider
	where Self: UIView
{
	public func installNibView()
	{
		//		DispatchQueue.once
		
		//		self.getAssociatedObject(Bool.self)
		
		// Prevents infinite loop from UINib.instantiate
		// calling init?(coder aDecoder: NSCoder)
		// false when called from storyboard, true when called from UINib.instantiate
		//		guard !self.translatesAutoresizingMaskIntoConstraints else { return }
		//guard self.getAssociatedObject(Self.self) == nil else { return }
		//self.setAssociatedObject(self, policy: .OBJC_ASSOCIATION_ASSIGN)
		//		print(AssociatedObject.identifer(Self.self).hashValue)
		
		guard self.get(associatedObject: "nibProviderView", UIView.self) == nil else { return }
		
		//		guard self.subviews.count == 0 else { return }
		//		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.setNeedsLayout()
		//		self.layoutIfNeeded()
		
		if let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView {
			self.set(associatedObject: "nibProviderView", object: view)
			//			view.tag = AssociatedObject.identifer(Self.self).hashValue
			view.translatesAutoresizingMaskIntoConstraints = false
			self.addSubview(view)
			view.constrainTo(view: self)
			
			//			self.setNeedsLayout()
			view.setNeedsLayout()
			//			self.layoutIfNeeded()
			//			view.layoutIfNeeded()
			//			view.setNeedsLayout()
			//			view.layoutIfNeeded()
		}
		
		//		self.setNeedsLayout()
		//		self.layoutIfNeeded()
		//		self.setNeedsLayout()
		
		
		
		
		//		if let view = Self.nib.instantiate(withOwner: self, Self.self) {
		////			if let view = Self.nib.instantiate(withOwner: self, viewType: Self.self) {
		//			self.addSubview(view)
		//			view.frame = self.bounds
		////			view.translatesAutoresizingMaskIntoConstraints = false
		////			view.constrainTo(view: self)
		//		}
	}
}




