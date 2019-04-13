//
//  UIView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-03.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit





public extension NSObjectProtocol
	where Self: UIView
{
	@discardableResult
	func superview(_ superview: UIView) -> Self
	{
		superview.addSubview(self)
		
		return self
	}
	
	
	
	/// wrapper for systemLayoutSizeFitting(targetSize:)
	func systemSize(fitting targetSize: CGSize = UIView.layoutFittingCompressedSize) -> CGSize
	{
		return self.systemLayoutSizeFitting(targetSize)
	}
	
	/// wrapper for systemLayoutSizeFitting(targetSize:withHorizontalFittingPriority:verticalFittingPriority)
	func systemSize(fitting targetSize: CGSize = UIView.layoutFittingCompressedSize,
					horizontal: UILayoutPriority,
					vertical: UILayoutPriority) -> CGSize
	{
		return self.systemLayoutSizeFitting(targetSize,
											withHorizontalFittingPriority: horizontal,
											verticalFittingPriority: vertical)
	}
	
	/// wrapper for setContentHuggingPriority(priority:for:)
	/// The priority with which a view resists being made larger than its intrinsic size.
	@discardableResult
	func contentHugging(priority: UILayoutPriority,
						for axis: NSLayoutConstraint.Axis) -> Self
	{
		self.setContentHuggingPriority(priority, for: axis)
		
		return self
	}
	
	/// wrapper for setContentCompressionResistancePriority(priority:for:)
	/// The priority with which a view resists being made smaller than its intrinsic size.
	@discardableResult
	func compressionResistance(priority: UILayoutPriority,
							   for axis: NSLayoutConstraint.Axis) -> Self
	{
		self.setContentCompressionResistancePriority(priority, for: axis)
		
		return self
	}
}




