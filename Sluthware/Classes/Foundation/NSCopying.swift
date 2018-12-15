//
//  NSCopying.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension NSCopying
{
	func makeCopy(with: NSZone? = nil) throws -> Self
	{
		if let copy = self.copy(with: with) as? Self {
			return copy
		} else {
			throw Errors.Message(#function + " failed")
		}
	}
}





