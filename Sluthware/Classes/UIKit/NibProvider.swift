//
//  NibProvider.swift
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





public extension UINib
{
	public typealias Provider = NibProvider
}





public extension UINib.Provider
	where Self: UIView
{
	@available(*, deprecated, renamed: "installNib")
	public func installNibView()
	{
		self.installNib()
	}
	
	public func installNib()
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
		guard let nibView = Self.nib.instantiate(withOwner: self, options: nil)
			.first as? UIView else { return }
		//		guard self.subviews.count == 0 else { return }
		//		self.translatesAutoresizingMaskIntoConstraints = false
		
		self.setNeedsLayout()
		//		self.layoutIfNeeded()
		
		self.set(associatedObject: "nibProviderView", object: nibView)
		nibView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(nibView)
		
		NSLayoutConstraint.activate([
			nibView.topAnchor.constraint(equalTo: self.topAnchor),
			nibView.leftAnchor.constraint(equalTo: self.leftAnchor),
			nibView.rightAnchor.constraint(equalTo: self.rightAnchor),
			nibView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
			])
		
		//			self.setNeedsLayout()
		nibView.setNeedsLayout()
		//			self.layoutIfNeeded()
		//			view.layoutIfNeeded()
		//			view.setNeedsLayout()
		//			view.layoutIfNeeded()
		
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




