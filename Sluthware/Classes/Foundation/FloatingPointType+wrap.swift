//
//  FloatingPointType+wrap.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension FloatingPointType
{
    ////// wrap x to interval [0, max)
    static func wrap(_ x: Self, max: Self) -> Self {
        return fmod(max + fmod(x, max), max)
    }
    
    /// wrap x to interval [min, max)
    static func wrap(_ x: Self, min: Self, max: Self) -> Self {
        return min + Self.wrap(x - min, max: max - min)
    }
    
    /// wrap to interval [0, max)
    func wrapped(max: Self) -> Self {
        return Self.wrap(self, max: max)
    }
    
    /// wrap to interval [min, max)
    func wrapped(min: Self, max: Self) -> Self {
        return Self.wrap(self, min: min, max: max)
    }
}




