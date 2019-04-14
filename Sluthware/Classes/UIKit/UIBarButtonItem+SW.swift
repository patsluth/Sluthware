//
//  UIBarButtonItem+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import UIKit





public extension UIBarButtonItem
{
//	public init?(coder aDecoder: NSCoder)
//
//	public convenience init(image: UIImage?, style: UIBarButtonItem.Style, target: Any?, action: Selector?)
//
//	@available(iOS 5.0, *)
//	public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItem.Style, target: Any?, action: Selector?) // landscapeImagePhone will be used for the bar button image when the bar has Compact or Condensed bar metrics.
//
//	public convenience init(title: String?, style: UIBarButtonItem.Style, target: Any?, action: Selector?)
//
//	public convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, target: Any?, action: Selector?)
//
//	public convenience init(customView: UIView)
	
	convenience init(systemItem: UIBarButtonItem.SystemItem)
	{
		self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
	}
	
	convenience init(image: UIImage?, style: UIBarButtonItem.Style = .plain)
	{
		self.init(image: image, style: style, target: nil, action: nil)
	}
}




