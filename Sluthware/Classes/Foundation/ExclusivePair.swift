//
//  ExclusivePair.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-06-20.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation





// Represents two values where one is not nil and the other is nil
public enum ExclusivePair<_A, _B>
{
	case A(_A)
	case B(_B)
	
	
	
	
	
	public var a: _A? {
		guard case let .A(a) = self else { return nil }
		return a
	}
	
	public var b: _B? {
		guard case let .B(b) = self else { return nil }
		return b
	}
	
	public init?(_ a: _A?, _ b: _B?)
	{
		if let a = a, b == nil {
			self = .A(a)
		} else if let b = b, a == nil {
			self = .B(b)
		} else {
			return nil
		}
	}
}





extension ExclusivePair: Equatable
	where _A: Equatable, _B: Equatable
{
	public static func == (lhs: ExclusivePair<_A, _B>, rhs: ExclusivePair<_A, _B>) -> Bool
	{
		return (lhs.a == rhs.a && lhs.b == rhs.b)
	}
}




