//
//  Set+Safe.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-04-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public extension Set
{
	func indexFor(arrayIndex: Array<Element>.Index?) -> Index?
	{
		guard let arrayIndex = arrayIndex else { return nil }
		return self.index(self.startIndex, offsetBy: arrayIndex)
	}
	
    subscript(safe arrayIndex: Array<Element>.Index?) -> Element?
	{
		return self[safe: self.indexFor(arrayIndex: arrayIndex)]
	}
}




