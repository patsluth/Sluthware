//
//  ExecutionTime.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-03-01.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation
import QuartzCore





public enum ExecutionTime
{
	public static func of(_ closure: () -> Void, completedIn: (TimeInterval) -> Void) -> Void
	{
		let start = CACurrentMediaTime()
		closure()
		completedIn(CACurrentMediaTime() - start)
	}
}




