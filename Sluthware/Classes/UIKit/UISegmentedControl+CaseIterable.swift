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
	public convenience init<T>(_ type: T.Type)
		where T: RawRepresentable, T: CaseIterable, T.RawValue == String
	{
		let items = type.allCases.map({ $0.rawValue })
		
		self.init(items: items)
		
		defer {
			if !items.isEmpty {
				self.selectedSegmentIndex = 0
			}
		}
	}
	
	public func setItems<T>(_ type: T.Type, animated: Bool = false)
		where T: RawRepresentable, T: CaseIterable, T.RawValue == String
	{
		self.removeAllSegments()
		
		for (i, title) in type.allCases.enumerated() {
			self.insertSegment(withTitle: title.rawValue, at: i, animated: animated)
		}
		
		self.selectedSegmentIndex = 0
	}
}



