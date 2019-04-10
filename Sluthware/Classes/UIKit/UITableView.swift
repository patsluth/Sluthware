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
	func registerCell<T>(_ type: T.Type,
						 nib: UINib?,
						 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewCell
	{
		self.register(nib, forCellReuseIdentifier: reuseIdentifier)
	}
	
	func registerCell<T>(_ type: T.Type,
						 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewCell & UINib.Provider
	{
		self.registerCell(type, nib: T.nib)
	}
	
	@available(iOS 6.0, *)
	func registerCell<T>(_  type: T.Type,
						 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewCell
	{
		self.register(T.self, forCellReuseIdentifier: reuseIdentifier)
	}
	
	@available(iOS 6.0, *)
	func registerHeaderFooter<T>(_ type: T.Type,
								 nib: UINib?,
								 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewHeaderFooterView
	{
		self.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
	}
	
	func registerHeaderFooter<T>(_ type: T.Type,
								 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewHeaderFooterView & UINib.Provider
	{
		self.registerHeaderFooter(type, nib: T.nib)
	}
	
	@available(iOS 6.0, *)
	func registerHeaderFooter<T>(_ type: T.Type,
								 reuseIdentifier: String = "\(T.self)")
		where T: UITableViewHeaderFooterView
	{
		self.register(T.self, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
	}
	
	
	
	func dequeue<T>(_ type: T.Type,
					reuseIdentifier: String = "\(T.self)") -> T?
		where T: UITableViewCell
	{
		return self.dequeueReusableCell(withIdentifier: reuseIdentifier) as? T
	}
	
	@available(iOS 6.0, *)
	func dequeue<T>(_ type: T.Type,
					for indexPath: IndexPath,
					reuseIdentifier: String = "\(T.self)") -> T
		where T: UITableViewCell
	{
		return self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
	}
	
	@available(iOS 6.0, *)
	func dequeueHeaderFooter<T>(_ type: T.Type,
								reuseIdentifier: String = "\(T.self)") -> T?
		where T: UITableViewHeaderFooterView
	{
		return self.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as? T
	}
	
	
	
	func cell<T>(_ type: T.Type,
				 at indexPath: IndexPath) -> T?
		where T: UITableViewCell
	{
		return self.cellForRow(at: indexPath) as? T
	}
}





public extension UITableView
{
	fileprivate var prototypeCells: [String: UITableViewCell] {
		get
		{
			return self.get(associatedObject: "prototypeCells", [String: UITableViewCell].self) ?? [:]
		}
		set
		{
			self.set(associatedObject: "prototypeCells", object: newValue)
		}
	}
	
	
	
	
	
	func prototype(reuseIdentifier: String) -> UITableViewCell?
	{
		if let cell = self.prototypeCells[reuseIdentifier] {
			return cell
		}
		
		let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier)
		self.prototypeCells[reuseIdentifier] = cell
		
		return cell
	}
	
	func prototype<T>(_ type: T.Type,
					  reuseIdentifier: String = "\(T.self)") -> T
		where T: UITableViewCell
	{
		if let cell = self.prototype(reuseIdentifier: reuseIdentifier) as? T {
			return cell
		}
		
		return T.make({
			self.prototypeCells[reuseIdentifier] = $0
		})
	}
}




