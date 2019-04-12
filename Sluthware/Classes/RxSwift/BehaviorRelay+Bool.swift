//
//  BehaviorRelay+Bool.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa





public extension BehaviorRelay
	where Element == Bool
{
	func toggle()
	{
		self.accept(!self.value)
	}
}




