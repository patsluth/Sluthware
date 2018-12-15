//
//  Array.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Array
{
	public mutating func popFirst() -> Element?
	{
		if let first = self.first {
			self.removeFirst()
			return first
		}
		
		return nil
	}
}




