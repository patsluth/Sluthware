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
	func register<T>(_ nib: UINib?,
					 of type: T.Type,
					 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewCell
	{
		self.register(nib, forCellReuseIdentifier: reuseIdentifier)
	}
	
	@available(iOS 6.0, *)
	func registerCell<T>(of type: T.Type,
						 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewCell
	{
		self.register(T.self, forCellReuseIdentifier: reuseIdentifier)
	}
	
	@available(iOS 6.0, *)
	func registerHeaderFooterView<T>(_ nib: UINib?,
									 of type: T.Type,
									 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewHeaderFooterView
	{
		self.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
	}
	
	@available(iOS 6.0, *)
	func registerHeaderFooterView<T>(of type: T.Type,
									 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewHeaderFooterView
	{
		self.register(T.self, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
	}
	
	
	
	func dequeueReusableCell<T>(of type: T.Type,
								reuseIdentifier: String = "\(T.self)") -> T?
		where T: UITableViewCell
	{
		return self.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T
	}
	
	@available(iOS 6.0, *)
	func dequeueReusableCell<T>(of type: T.Type,
								for indexPath: IndexPath,
								reuseIdentifier: String = "\(T.self)") -> T
		where T: UITableViewCell
	{
		return self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
	}
	
	@available(iOS 6.0, *)
	func dequeueReusableHeaderFooterView<T>(of type: T.Type,
											reuseIdentifier: String = "\(T.self)") -> T?
		where T: UITableViewHeaderFooterView
	{
		return self.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T
	}
	
	
	
	func cellForRow<T>(of type: T.Type,
					   at indexPath: IndexPath) -> T?
		where T: UITableViewCell
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
	
	
	
	func prototypeCell<T>(of type: T.Type,
						  reuseIdentifier: String = "\(T.self)") -> T?
		where T: UITableViewCell
	{
		return self.prototypeCell(withIdentifier: reuseIdentifier) as? T
	}
}




