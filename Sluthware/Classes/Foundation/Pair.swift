//
//  ExclusivePair.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-06-20.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation





public struct Pair<A, B>
{
	var a: A
	var b: B
	
	
	
	
	
	public init(_ a: A, _ b: B)
	{
		self.a = a
		self.b = b
	}
	
	public init?(_ a: A?, _ b: B?)
	{
		guard let a = a, let b = b else { return nil }
		self.init(a, b)
	}
}





extension Pair: Equatable
	where A: Equatable, B: Equatable
{
	public static func == (lhs: Pair<A, B>, rhs: Pair<A, B>) -> Bool
	{
		return (lhs.a == rhs.a && lhs.b == rhs.b)
	}
}




