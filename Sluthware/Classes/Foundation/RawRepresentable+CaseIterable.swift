//
//  RawRepresentable+CaseIterable.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





// TODO: Fix

// Not Wrapped
postfix operator +
postfix operator -
// Wrapped
postfix operator <+>
postfix operator <->
// Not Wrapped
postfix operator ++
postfix operator --
// Wrapped
postfix operator <++>
postfix operator <-->





#if swift(>=4.2)

public extension RawRepresentable
	where Self: CaseIterable,
	Self: Equatable,
	Self.AllCases == [Self]
{
	init?(index: Int)
	{
		if let _case = Self.allCases[safe: index] {
			self = _case
		} else {
			return nil
		}
	}
	
	
	
	func nextCase(wrapped: Bool = false) -> Self?
	{
		guard let index = Self.allCases.firstIndex(of: self) else { return nil }
		
		if let nextCase = Self.allCases[safe: index + 1] {
			return nextCase
		} else {
			return (wrapped) ? Self.allCases.first : nil
		}
	}
	
	func prevCase(wrapped: Bool = false) -> Self?
	{
		guard let index = Self.allCases.firstIndex(of: self) else { return nil }
		
		if let prevCase = Self.allCases[safe: index - 1] {
			return prevCase
		} else {
			return (wrapped) ? Self.allCases.last : nil
		}
	}
	
	
	
	
	
	postfix static func + (lhs: Self) -> Self
	{
		return (lhs.nextCase(wrapped: false) ?? lhs)
	}
	
	postfix static func - (lhs: Self) -> Self
	{
		return (lhs.prevCase(wrapped: false) ?? lhs)
	}
	
	
	
	postfix static func <+> (lhs: inout Self)
	{
		guard let nextCase = lhs.nextCase(wrapped: true) else { return }
		lhs = nextCase
	}
	
	postfix static func <-> (lhs: inout Self)
	{
		guard let nextCase = lhs.prevCase(wrapped: true) else { return }
		lhs = nextCase
	}
	
	
	
	postfix static func ++ (lhs: inout Self)
	{
		guard let nextCase = lhs.nextCase(wrapped: false) else { return }
		lhs = nextCase
	}
	
	postfix static func -- (lhs: inout Self)
	{
		guard let prevCase = lhs.prevCase(wrapped: false) else { return }
		lhs = prevCase
	}
	
	
	
	postfix static func <++> (lhs: inout Self)
	{
		guard let nextCase = lhs.nextCase(wrapped: true) else { return }
		lhs = nextCase
	}
	
	postfix static func <--> (lhs: inout Self)
	{
		guard let prevCase = lhs.prevCase(wrapped: true) else { return }
		lhs = prevCase
	}
}

#endif




