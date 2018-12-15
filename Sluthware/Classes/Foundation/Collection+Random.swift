//
//  Array+Safe.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Collection
{
	var random: Element? {
		let randomIndex = self.index(self.startIndex, offsetBy: Int.random((0..<self.count)))
		return self[safe: randomIndex]
	}
}




