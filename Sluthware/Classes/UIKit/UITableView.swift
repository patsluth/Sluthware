//
//  UITableView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import ObjectiveC





public extension UITableView
{
	@available(iOS 5.0, *)
	func register<T>(_ nib: UINib?, of type: T.Type)
	{
		self.register(nib, forCellReuseIdentifier: "\(T.self)")
	}
	
	@available(iOS 6.0, *)
	func registerCell<T>(of type: T.Type)
		where T: AnyObject
	{
		self.register(T.self, forCellReuseIdentifier: "\(T.self)")
	}
	
	@available(iOS 6.0, *)
	func registerHeaderFooterView<T>(_ nib: UINib?, of type: T.Type)
	{
		self.register(nib, forHeaderFooterViewReuseIdentifier: "\(T.self)")
	}
	
	@available(iOS 6.0, *)
	func registerHeaderFooterView<T>(of type: T.Type)
		where T: AnyObject
	{
		self.register(T.self, forHeaderFooterViewReuseIdentifier: "\(T.self)")
	}
	
	
	
	func dequeueReusableCell<T>(of type: T.Type) -> T?
		where T: UITableViewCell
	{
		return self.dequeueReusableCell(withIdentifier: "\(T.self)") as? T
	}
	
	@available(iOS 6.0, *)
	func dequeueReusableCell<T>(of type: T.Type, for indexPath: IndexPath) -> T
		where T: UITableViewCell
	{
		return self.dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as! T
	}
	
	@available(iOS 6.0, *)
	func dequeueReusableHeaderFooterView<T>(of type: T.Type) -> T?
		where T: UITableViewHeaderFooterView
	{
		return self.dequeueReusableHeaderFooterView(withIdentifier: "\(T.self)") as? T
	}
	
	
	
	func cellForRow<T>(of type: T.Type, at indexPath: IndexPath) -> T?
	{
		return self.cellForRow(at: indexPath) as? T
	}
}





fileprivate var _prototypeCells = Selector(("_prototypeCells"))

public extension UITableView
{
	fileprivate var prototypeCells: [String: UITableViewCell] {
		get
		{
			return (objc_getAssociatedObject(self, &_prototypeCells) as? [String: UITableViewCell]) ?? [:]
		}
		set
		{
			objc_setAssociatedObject(self,
									 &_prototypeCells,
									 newValue,
									 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	
	
	
	
	func prototypeCell(withIdentifier identifier: String) -> UITableViewCell?
	{
		if let cell = self.prototypeCells[identifier] {
			return cell
		}
		
		let cell = self.dequeueReusableCell(withIdentifier: identifier)
		self.prototypeCells[identifier] = cell
		
		return cell
	}
	
	
	
	func prototypeCell<T>(of type: T.Type) -> T?
	{
		return self.prototypeCell(withIdentifier: "\(T.self)") as? T
	}
}




