//
//  DispatchQueue+once.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public extension DispatchQueue
{
	private static var _onceTracker = Set<String>()
	
	public class func once(file: String = #file,
						   function: String = #function,
						   line: Int = #line,
						   block: () -> Void)
	{
		let token = "\(file):\(function):\(line)"
		DispatchQueue.once(token: token, block: block)
	}
	
	/**
	Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
	only execute the code once even in the presence of multithreaded calls.
	
	- parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
	- parameter block: Block to execute once
	*/
	public class func once(token: String,
						   block: () -> Void)
	{
		objc_sync_enter(self)
		defer { objc_sync_exit(self) }
		
		guard self._onceTracker.insert(token).inserted else { return }
		
		block()
	}
}




