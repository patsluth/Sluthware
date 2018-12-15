//
//  UIButton.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-02.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension UIView
{
	@available(*, deprecated, renamed: "constrainTo(view:with:)")
	public func constrainSizeTo(view: UIView, withEdgeInsets edgeInsets: UIEdgeInsets)
	{
		self.constrainTo(view: view, with: edgeInsets)
	}
	
	@objc public func constrainTo(view: UIView, with edgeInsets: UIEdgeInsets = UIEdgeInsets.zero)
	{
		NSLayoutConstraint.activate([
			self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInsets.top),
			self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: edgeInsets.left),
			self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: edgeInsets.bottom),
			self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: edgeInsets.right),
			])
	}
}





public extension UIView
{
	public var safeTopAnchor: NSLayoutYAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.topAnchor
		} else {
			return self.topAnchor
		}
	}
	
	public var safeLeftAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *){
			return self.safeAreaLayoutGuide.leftAnchor
		} else {
			return self.leftAnchor
		}
	}
	
	public var safeLeadingAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *){
			return self.safeAreaLayoutGuide.leadingAnchor
		} else {
			return self.leadingAnchor
		}
	}
	
	public var safeRightAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *){
			return self.safeAreaLayoutGuide.rightAnchor
		} else {
			return self.rightAnchor
		}
	}
	
	public var safeTrailingAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *){
			return self.safeAreaLayoutGuide.trailingAnchor
		} else {
			return self.trailingAnchor
		}
	}
	
	public var safeBottomAnchor: NSLayoutYAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.bottomAnchor
		} else {
			return self.bottomAnchor
		}
	}
}




