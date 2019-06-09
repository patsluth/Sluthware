//
//  UIView+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-03.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit




public extension UIView
{
	public enum Fitting
	{
		// TODO: Use .Width/.Height with expanded
		case CompressedSize
		case ExpandedSize
		//		case Size(CGSize)
		case Width(CGFloat)
		case Height(CGFloat)
		
		
		
		
		
		fileprivate var fittingSize: CGSize {
			switch self {
			case .CompressedSize:
				return UIView.layoutFittingCompressedSize
			case .ExpandedSize:
				return UIView.layoutFittingExpandedSize
				//			case .Size(let fittingSize):
			//				return fittingSize
			case .Width(let fittingWidth):
				return UIView.layoutFittingCompressedSize.with(width: fittingWidth)
			case .Height(let fittingHeight):
				return UIView.layoutFittingCompressedSize.with(width: fittingHeight)
			}
		}
		
		fileprivate func systemSize(for view: UIView) -> CGSize
		{
			switch self {
			case .CompressedSize:
				return view.systemSize(fittingSize: self.fittingSize)
			case .ExpandedSize:
				return view.systemSize(fittingSize: self.fittingSize)
				//				case .Size(let fittingSize):
			//					return view.systemSize(fitting: fittingSize)
			case .Width(_):
				return view.systemSize(fittingSize: self.fittingSize,
									   horizontal: .required,
									   vertical: .fittingSizeLevel)
			case .Height(let fittingHeight):
				return view.systemSize(fittingSize: self.fittingSize,
									   horizontal: .required,
									   vertical: .fittingSizeLevel)
			}
		}
	}
}





public extension NSObjectProtocol
	where Self: UIView
{
	@discardableResult
	func addTo(superview: UIView) -> Self
	{
		superview.addSubview(self)
		
		return self
	}
	
	@discardableResult
	func addTo(superview provider: () -> UIView) -> Self
	{
		return self.addTo(superview: provider())
	}
	
	
	
	/// wrapper for systemLayoutSizeFitting(targetSize:)
	func systemSize(fittingSize targetSize: CGSize = UIView.layoutFittingCompressedSize) -> CGSize
	{
		return self.systemLayoutSizeFitting(targetSize)
	}
	
	/// wrapper for systemLayoutSizeFitting(targetSize:withHorizontalFittingPriority:verticalFittingPriority)
	func systemSize(fittingSize targetSize: CGSize = UIView.layoutFittingCompressedSize,
					horizontal: UILayoutPriority,
					vertical: UILayoutPriority) -> CGSize
	{
		return self.systemLayoutSizeFitting(targetSize,
											withHorizontalFittingPriority: horizontal,
											verticalFittingPriority: vertical)
	}
	
	
	
	
	//	func systemSize(fitting: UIView.Fitting = .CompressedSize) -> CGSize
	// TODO: Rename
	func systemSizeFitting(_ fitting: UIView.Fitting = .CompressedSize) -> CGSize
	{
		return fitting.systemSize(for: self)
		//		switch fitting {
		//		case .CompressedSize:
		//			return self.systemSize(fitting: UIView.layoutFittingCompressedSize)
		//		case .ExpandedSize:
		//			<#code#>
		////		case .Size(let fittingSize):
		////			<#code#>
		//		case .Width(let fittingWidth):
		//			<#code#>
		//		case .Height(let fittingHeight):
		//			<#code#>
		//		}
		//
		//		let fittingSize = UIView.layoutFittingCompressedSize.with(width: targetWidth)
		//
		//		return self.systemSize(fitting: fittingSize,
		//							   horizontal: .required,
		//							   vertical: .fittingSizeLevel)
	}
	
	//	func systemSize(fittingWidth targetWidth: CGFloat) -> CGSize
	//	{
	//		let fittingSize = UIView.layoutFittingCompressedSize.with(width: targetWidth)
	//
	//		return self.systemSize(fitting: fittingSize,
	//							   horizontal: .required,
	//							   vertical: .fittingSizeLevel)
	//	}
	//
	//	func systemSize(fittingHeight targetHeight: CGFloat) -> CGSize
	//	{
	//		let fittingSize = UIView.layoutFittingCompressedSize.with(height: targetHeight)
	//
	//		return self.systemSize(fitting: fittingSize,
	//							   horizontal: .fittingSizeLevel,
	//							   vertical: .required)
	//	}
	
	
	
	
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




