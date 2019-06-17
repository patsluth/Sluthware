//
//  SafeSubscript.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension Collection
{
	subscript(safe index: Index?) -> Element?
	{
		guard let index = index else { return nil }
		guard self.indices.contains(index) else { return nil }
		return self[index]
	}
}





public extension Collection
	where Index == Int
{
	subscript(safe range: Range<Index>?) -> [Element?]
	{
		var elements = [Element?]()
		guard let range = range else { return elements }
		for i in range {
			elements += self[safe: i]
		}
		return elements
	}
}





public extension Dictionary
{
	subscript(safe key: Key?) -> Value?
	{
		guard let key = key else { return nil }
		let index = self.index(forKey: key)
		return self[safe: index]?.value
	}
}




