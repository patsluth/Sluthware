//
//  ReflectedStringConvertible.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public protocol ReflectedStringConvertible: CustomStringConvertible
{
}





public extension ReflectedStringConvertible
{
	public var description: String {
		let mirror = Mirror(reflecting: self)
		
		var description = "\(mirror.subjectType)("
		for (index, element) in mirror.children.enumerated() {
			if let label = element.label {
				if index > 0 {
					description += ", "
				}
				description += label
				description += ": "
				description += "\(element.value)"
			}
		}
		description += ")"
		
		return description
	}
}




