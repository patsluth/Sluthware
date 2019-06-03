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
	func lastIndexPath(inSection section: Int? = nil) -> IndexPath?
	{
		let section = section ?? self.numberOfSections - 1
		let item = self.numberOfItems(inSection: section) - 1
		
		return IndexPath(item: item, section: section)
	}
}





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
	
	/// Wrapper for registerSupplementary kind UICollectionView.elementKindSectionHeader
	func registerHeader<T>(_ type: T.Type,
						   reuseIdentifier: String = "\(T.self)")
		where T: UICollectionReusableView
	{
		self.registerSupplementary(type,
								   kind: UICollectionView.elementKindSectionHeader,
								   reuseIdentifier: reuseIdentifier)
	}
	
	/// Wrapper for registerSupplementary kind UICollectionView.elementKindSectionFooter
	func registerFooter<T>(_ type: T.Type,
						   reuseIdentifier: String = "\(T.self)")
		where T: UICollectionReusableView
	{
		self.registerSupplementary(type,
								   kind: UICollectionView.elementKindSectionFooter,
								   reuseIdentifier: reuseIdentifier)
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





public extension UICollectionView
{
	fileprivate var prototypeCells: [String: UICollectionViewCell] {
		get
		{
			return self.get(associatedObject: "prototypeCells", [String: UICollectionViewCell].self) ?? [:]
		}
		set
		{
			self.set(associatedObject: "prototypeCells", object: newValue)
		}
	}
	
	
	
	
	func prototype<T>(_ type: T.Type,
					  reuseIdentifier: String = "\(T.self)") -> T
		where T: UICollectionViewCell
	{
		if let cell = self.prototypeCells[reuseIdentifier] as? T {
			return cell
		}
		
		return T.make({
			self.prototypeCells[reuseIdentifier] = $0
		})
	}
}






