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
	
	func registerSupplementaryView<T>(_ type: T.Type,
									  kind: String,
									  reuseIdentifier: String = "\(T.self)")
		where T: UICollectionReusableView
	{
		self.register(type,
					  forSupplementaryViewOfKind: kind,
					  withReuseIdentifier: reuseIdentifier)
	}
	
	func registerSupplementaryView<T>(_ type: T.Type,
									  kind: String,
									  reuseIdentifier: String = "\(T.self)")
		where T: UICollectionViewCell & UINib.Provider
	{
		self.registerSupplementaryView(type, nib: T.nib, kind: kind)
	}
	
	func registerSupplementaryView<T>(_ type: T.Type,
									  nib: UINib?,
									  kind: String,
									  reuseIdentifier: String = "\(T.self)")
		where T: UICollectionReusableView
	{
		self.register(nib,
					  forSupplementaryViewOfKind: kind,
					  withReuseIdentifier: reuseIdentifier)
	}
	
	
	
	
	func dequeueReusableCell<T>(_ type: T.Type,
								for indexPath: IndexPath,
								reuseIdentifier: String = "\(T.self)") -> T
		where T: UICollectionViewCell
	{
		return self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
	}
	
	func dequeueReusableSupplementaryView<T>(_ type: T.Type,
											 kind: String,
											 for indexPath: IndexPath,
											 reuseIdentifier: String = "\(T.self)") -> T
		where T: UICollectionReusableView
	{
		return self.dequeueReusableSupplementaryView(ofKind: kind,
													 withReuseIdentifier: reuseIdentifier,
													 for: indexPath) as! T
	}
}




