//
//  SnapKit+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import UIKit

import SnapKit





public extension NSObjectProtocol
	where Self: UIView
{
	@discardableResult
	func make(constraints block: (ConstraintMaker) -> Void) -> Self
	{
		self.snp.makeConstraints({
			block($0)
		})
		
		return self
	}
	
	@discardableResult
	func make(constraints block: (ConstraintMaker, Self) -> Void) -> Self
	{
		self.snp.makeConstraints({
			block($0, self)
		})
		
		return self
	}
	
	@discardableResult
	func remake(constraints block: (ConstraintMaker) -> Void) -> Self
	{
		self.snp.remakeConstraints({
			block($0)
		})
		
		return self
	}
	
	@discardableResult
	func remake(constraints block: (ConstraintMaker, Self) -> Void) -> Self
	{
		self.snp.remakeConstraints({
			block($0, self)
		})
		
		return self
	}
	
	@discardableResult
	func update(constraints block: (ConstraintMaker) -> Void) -> Self
	{
		self.snp.updateConstraints({
			block($0)
		})
		
		return self
	}
	
	@discardableResult
	func update(constraints block: (ConstraintMaker, Self) -> Void) -> Self
	{
		self.snp.updateConstraints({
			block($0, self)
		})
		
		return self
	}
}





