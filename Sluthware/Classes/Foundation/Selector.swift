//
//  Selector.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Selector
{
	var isGetter: Bool {
		return !self.isSetter
	}
	
	var isSetter: Bool {
		let string = "\(self)"
		return (string.hasPrefix("set") && string.hasSuffix(":"))
	}
	
	var asGetter: Selector {
		guard self.isSetter else { return self }
		
		let string = "\(self)".dropFirst(3).dropLast(1)
		let letter = string.prefix(1).lowercased()
		return Selector(letter + string.dropFirst(1))
	}
	
	var asSetter: Selector {
		guard self.isGetter else { return self }
		
		let string = "\(self)"
		let letter = string.prefix(1).uppercased()
		return Selector("set" + letter + string.dropFirst(1) + ":")
	}
}




