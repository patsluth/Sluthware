//
//  UITableViewCellBase.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import UIKit





open class UITableViewCellBase: UITableViewCell
{
	open override func layoutSubviews()
	{
		super.layoutSubviews()
		
		self.contentView.layoutMargins.left = CGFloat(self.indentationLevel) * self.indentationWidth
		self.contentView.layoutIfNeeded()
	}
}




