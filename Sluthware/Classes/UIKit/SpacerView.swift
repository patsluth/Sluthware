//
//  SpacerView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import UIKit





public final class SpacerView: SeparatorView
{
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		self.lineView.backgroundColor = nil
		
		defer {
			self.value = 0
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
	}
}




