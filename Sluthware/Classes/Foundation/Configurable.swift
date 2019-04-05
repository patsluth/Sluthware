//
// 	Configurable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import Foundation





public protocol Configurable: NSObjectProtocol { }

extension NSObject: Configurable { }

public extension Configurable
{
	@discardableResult
	func configure(_ block: (Self) -> Void) -> Self
	{
		block(self)
		
		return self
	}
}




