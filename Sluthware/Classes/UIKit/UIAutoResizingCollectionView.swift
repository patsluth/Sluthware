//
//  UIAutoResizingCollectionView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public class UIAutoResizingCollectionView: UICollectionView
{
	public override var collectionViewLayout: UICollectionViewLayout {
		didSet
		{
			self.reloadData()
		}
	}
	
	public override var intrinsicContentSize: CGSize {
		var contentSize = self.collectionViewLayout.collectionViewContentSize
		if let flow = self.collectionViewLayout as? UICollectionViewFlowLayout {
			switch flow.scrollDirection {
				case .horizontal:
					contentSize.width = -1
				case .vertical:
					contentSize.height = -1
				@unknown default:
					break
			}
			
		}
		return contentSize
	}
	
	
	
	
	
	public override func reloadData()
	{
		super.reloadData()
		
		self.invalidateIntrinsicContentSize()
	}
}




