//
//  Error.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public extension Error
{
	public var ns: NSError {
		return self as NSError
	}
	
	
	
	
	
	public func log(file: String = #file,
					function: String = #function,
					line: Int = #line)
	{
		print(file.fileNameFull, function, line, self)
	}
}




