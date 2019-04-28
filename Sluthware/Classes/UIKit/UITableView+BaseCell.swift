//
//  UITableView+BaseCell.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa





extension UITableView
{
	open class BaseCell: UITableViewCell
	{
		public private(set) var disposeBag = DisposeBag()
		
		open override var indentationLevel: Int {
			didSet
			{
				guard self.indentationLevel != oldValue else { return }
				
				self.updateLayoutMarginsForIndentation()
			}
		}
		
		open override var indentationWidth: CGFloat {
			didSet
			{
				guard self.indentationWidth != oldValue else { return }
				
				self.updateLayoutMarginsForIndentation()
			}
		}
		
		
		
		
		
		open override func prepareForReuse()
		{
			self.disposeBag = DisposeBag()
			
			super.prepareForReuse()
		}
		
		open func updateLayoutMarginsForIndentation()
		{
			self.contentView.layoutMargins.left = CGFloat(self.indentationLevel) * self.indentationWidth
			self.contentView.layoutIfNeeded()
		}
		
//		open override func layoutSubviews()
//		{
//			super.layoutSubviews()
//
//			self.contentView.layoutMargins.left = CGFloat(self.indentationLevel) * self.indentationWidth
//			self.contentView.layoutIfNeeded()
//		}
	}
}




