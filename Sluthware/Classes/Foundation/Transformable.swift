//
// 	Transformable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import Foundation





public protocol Transformable: NSObjectProtocol {}

extension NSObject: Transformable {}

public extension Transformable
{
	@discardableResult
	func configure(_ block: (Self) -> Void) -> Self
	{
		block(self)
		
		return self
	}
	
	func map<T>(_ block: (Self) -> T) -> T
	{
		return block(self)
	}
}




