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
    var description: String {
		let mirror = Mirror(reflecting: self)
		var mirrors = [mirror]
		var description = ""
		
		while let superMirror = mirrors.first?.superclassMirror {
			mirrors.insert(superMirror, at: 0)
		}
		
		func reduce(mirror: Mirror, into string: inout String)
		{
			for (index, element) in mirror.children.enumerated() {
				if let label = element.label {
					if index > 0 {
						string += ", "
					}
					string += label
					string += ": "
					string += "\(element.value)"
				}
			}
		}
		
		for (index, mirror) in mirrors.enumerated() {
			reduce(mirror: mirror, into: &description)
			if index < mirrors.count - 1 {
				description += ", "
			}
		}
		
		return "\(mirror.subjectType)(\(description))"
	}
}




