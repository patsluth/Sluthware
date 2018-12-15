//
//  CurrencyFormatter.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-14.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public final class CurrencyFormatter: NumberFormatter
{
	private let errorString: String
	
	
	
	
	
	public required init(errorString: String)
	{
		self.errorString = errorString
		
		super.init()
		
		self.numberStyle = NumberFormatter.Style.currency
		self.roundingMode = NumberFormatter.RoundingMode.halfUp
	}
	
	required public init?(coder aDecoder: NSCoder)
	{
		fatalError(#function + " has not been implemented")
	}
	
	public func string<T: FloatingPointType>(_ value: T?) -> String
	{
		guard let value = value else { return self.errorString }
		guard let string = self.string(from: NSNumber(value: Double(value))) else { return self.errorString }
		
		return string
	}
}




