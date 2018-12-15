//
//  KeyPath.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension KeyPath
{
	var stringValue: String {
		return NSExpression(forKeyPath: self).keyPath
	}
}




