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
	/// Remove all arranged subviews
	func removeAll()
	{
		self.remove(self.arrangedSubviews)
	}
	
	func add(_ arrangedSubviews: UIView...)
	{
		self.add(arrangedSubviews)
	}
	
	func add(_ arrangedSubviews: [UIView])
	{
		arrangedSubviews.forEach {
			self.addArrangedSubview($0)
		}
	}
	
	func remove(_ arrangedSubviews: UIView...)
	{
		self.remove(arrangedSubviews)
	}
	
	func remove(_ arrangedSubviews: [UIView])
	{
		arrangedSubviews.forEach {
			self.removeArrangedSubview($0)
		}
	}
}




