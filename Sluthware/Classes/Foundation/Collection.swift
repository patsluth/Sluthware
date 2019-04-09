//
//  Collection.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-11-28.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Collection
{
	@available(*, deprecated, renamed: "joined(separator:)")
	public func toString(separatedBy separator: String) -> String
	{
		var string = ""
		
//		for element in self {
//			string += String(describing: element) + separatedBy
//		}
//		if string.suffix(separatedBy.count) == separatedBy {
//			let index = string.index(string.endIndex, offsetBy: -separatedBy.count)
//			string = String(string[..<index])
//		}
		
		return self.joined(separator: separator)
	}
	
	public func joined(separator: String = " ") -> String
	{
		return self.map({ "\($0)" }).joined(separator: separator)
	}
}




