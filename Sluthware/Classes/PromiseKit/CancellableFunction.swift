//
//  CancellableFunction.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import CancelForPromiseKit





public class CancellableFunction: CancellableTask
{
	private var _function: (() -> Void)? = nil
	
	public var isCancelled: Bool {
		return (self._function == nil)
	}
	
	public init(_ function: @escaping () -> Void)
	{
		self._function = function
	}
	
	public func cancel()
	{
		self._function?()
		self._function = nil
	}
}




