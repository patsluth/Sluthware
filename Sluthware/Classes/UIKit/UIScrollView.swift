//
//  UIScrollView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import UIKit





public extension UIScrollView
{
	var isAtLeft: Bool {
		return (self.contentOffset.x <= 0.0)
	}
	
	var isAtRight: Bool {
		return (self.contentOffset.x >= (self.contentSize.width - self.bounds.width))
	}
	
	var isAtTop: Bool {
		return (self.contentOffset.y <= 0.0)
	}
	
	var isAtBottom: Bool {
		return (self.contentOffset.y >= (self.contentSize.height - self.bounds.height))
	}
}




