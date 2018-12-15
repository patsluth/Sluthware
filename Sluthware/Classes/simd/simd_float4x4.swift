//
//  simd_float4x4.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import simd





public extension simd_float4x4
{
	/**
	Treats matrix as a (right-hand column-major convention) transform matrix
	and factors out the translation component of the transform.
	*/
	var translation: simd_float3
	{
		let translation = columns.3
		return simd_float3(translation.x, translation.y, translation.z)
	}
}




