//
//  UICollectionView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension UICollectionView
{
	func registerCell<T>(_ type: T.Type,
						 reuseIdentifier: String = "\(T.self)")
		where T: UICollectionViewCell
	{
		self.register(type, forCellWithReuseIdentifier: reuseIdentifier)
	}
	
	func registerCell<T>(_ type: T.Type,
						 reuseIdentifier: String = "\(T.self)")
		where T: UICollectionViewCell & UINib.Provider
	{
		self.registerCell(type, nib: T.nib)
	}
	
	func registerCell<T>(_ type: T.Type,
						 nib: UINib?,
						 reuseIdentifier: String = "\(T.self)")
		where T: UICollectionViewCell
	{
		self.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
	}
	
	func registerSupplementary<T>(_ type: T.Type,
								  kind: String,
								  reuseIdentifier: String = "\(T.self)")
		where T: UICollectionReusableView
	{
		self.register(type,
					  forSupplementaryViewOfKind: kind,
					  withReuseIdentifier: reuseIdentifier)
	}
	
	func registerSupplementary<T>(_ type: T.Type,
								  kind: String,
								  reuseIdentifier: String = "\(T.self)")
		where T: UICollectionViewCell & UINib.Provider
	{
		self.registerSupplementary(type, nib: T.nib, kind: kind)
	}
	
	func registerSupplementary<T>(_ type: T.Type,
								  nib: UINib?,
								  kind: String,
								  reuseIdentifier: String = "\(T.self)")
		where T: UICollectionReusableView
	{
		self.register(nib,
					  forSupplementaryViewOfKind: kind,
					  withReuseIdentifier: reuseIdentifier)
	}
	
	
	
	
	func dequeue<T>(_ type: T.Type,
					for indexPath: IndexPath,
					reuseIdentifier: String = "\(T.self)") -> T
		where T: UICollectionViewCell
	{
		return self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
										for: indexPath) as! T
	}
	
	func dequeueSupplementary<T>(_ type: T.Type,
								 kind: String,
								 for indexPath: IndexPath,
								 reuseIdentifier: String = "\(T.self)") -> T
		where T: UICollectionReusableView
	{
		return self.dequeueReusableSupplementaryView(ofKind: kind,
													 withReuseIdentifier: reuseIdentifier,
													 for: indexPath) as! T
	}
	
	
	
	func cell<T>(_ type: T.Type,
				 at indexPath: IndexPath) -> T?
		where T: UICollectionViewCell
	{
		return self.cellForItem(at: indexPath) as? T
	}
}





fileprivate var _prototypeCells = Selector(("_prototypeCells"))

public extension UICollectionView
{
	fileprivate var prototypeCells: [String: UICollectionViewCell] {
		get
		{
			return (objc_getAssociatedObject(self, &_prototypeCells) as? [String: UICollectionViewCell]) ?? [:]
		}
		set
		{
			objc_setAssociatedObject(self,
									 &_prototypeCells,
									 newValue,
									 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	
	
	
	
	func prototype<T>(_ type: T.Type,
					  reuseIdentifier: String = "\(T.self)") -> T
		where T: UICollectionViewCell
	{
		if let cell = self.prototypeCells[reuseIdentifier] as? T {
			return cell
		}
		
		let cell = T()
		cell.translatesAutoresizingMaskIntoConstraints = false
		self.prototypeCells[reuseIdentifier] = cell
		
		return cell
	}
}






