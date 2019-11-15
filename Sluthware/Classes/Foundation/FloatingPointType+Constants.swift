//
//  FloatingPointType+Constants.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import Darwin





public extension FloatingPointType
{
    static var tau: Self {
        return Self.pi * Self(2)
    }
    
    static var pi_2: Self {
		return Self.pi / Self(2)
	}
	
    static var pi_4: Self {
		return Self.pi / Self(4)
	}
	
    static var pi_8: Self {
		return Self.pi / Self(8)
	}
    
    /// Eulers contant
    static var e: Self {
        return Self(Darwin.M_E)
    }
    
    /// Earths radius (kilometers)
    static var earth_km: Self {
        return 6378.137
    }
    
    /// Earths radius (meters)
    static var earth_m: Self {
        return 6378137
    }
	
	
	
    var toRad: Self {
		return Self.degToRad(deg: self)
	}
	
    static func degToRad(deg: Self) -> Self
	{
		return deg * Self.pi / Self(180.0)
	}
	
    var toDeg: Self {
		return Self.radToDeg(rad: self)
	}
	
    static func radToDeg(rad: Self) -> Self
	{
		return rad * Self(180.0) / Self.pi
	}
}




