//
//  UISegmentedControl+CaseIterable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-01-05.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation
import UIKit





public extension UISegmentedControl
{
	@available(swift, introduced: 4.2)
	public convenience init<T>(_ caseIterableType: T.Type)
		where T: RawRepresentable, T: CaseIterable, T.RawValue == String
	{
		let items = caseIterableType.allCases.map({ $0.rawValue })
		
		self.init(items: items)
		
		defer {
			if !items.isEmpty {
				self.selectedSegmentIndex = 0
			}
		}
	}
}



