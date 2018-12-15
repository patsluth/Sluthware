//
//  Collection+NumericOperations.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-11-28.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Collection
	where Element: NumbericType
{
	var sum: Element {
		return self.reduce(Element.zero, +)
	}
	
	var average: Element {
		let s: Double = self.sum.to()
		let c: Double = self.count.to()
		
		return (s / c).to()
	}
}




