//
//  CGPoint.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension CGPoint
{
	var integral: CGPoint {
		return CGPoint(x: Int(self.x), y: Int(self.y))
	}
	
	var rounded: CGPoint {
		return CGPoint(x: round(self.x), y: round(self.y))
	}
}




