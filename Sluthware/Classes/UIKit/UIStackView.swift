//
//  UIStackView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit





public extension UIStackView
{
	func removeAll()
	{
		self.arrangedSubviews.forEach({
			self.removeArrangedSubview($0)
		})
	}
}




