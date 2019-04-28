//
//  UICollectionView+BaseCell.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa





extension UICollectionView
{
	open class BaseCell: UICollectionViewCell
	{
		public private(set) var disposeBag = DisposeBag()
		
		
		
		
		
		open override func prepareForReuse()
		{
			self.disposeBag = DisposeBag()
			
			super.prepareForReuse()
		}
	}
}




