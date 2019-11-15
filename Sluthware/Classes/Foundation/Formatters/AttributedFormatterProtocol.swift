//
//  Fraction.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public protocol AttributedFormatterProtocol
{
	associatedtype Value

	init()
	func format(_ value: Value) -> NSAttributedString
}





public extension AttributedFormatterProtocol
{
    init(_ initBlock: (Self) -> Void)
	{
		self.init()
		
		defer {
			initBlock(self)
		}
	}
}




