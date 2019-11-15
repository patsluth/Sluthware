//
//  Collection+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-11-28.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Collection
{
	@available(*, deprecated, renamed: "joined(by:)")
	func toString(separatedBy separator: String) -> String
	{
		return self.joined(by: separator)
	}
	
	func joined(by separator: String) -> String
	{
		return self.map({ "\($0)" }).joined(separator: separator)
	}
}




