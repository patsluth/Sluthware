//
//  simd_float3.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit
import simd





infix operator ● // Dot product
infix operator × // Cross product





public extension simd_float3
{
	var length: SCNFloat {
		return simd_length(self)
	}
	
	var inverse: simd_float3 {
		return self * -1.0
	}
	
	/// Vector in the same direction as this vector with a magnitude of 1
	var normalized: simd_float3 {
		return simd_normalize(self)
	}
	
	static var zero: simd_float3 {
		return simd_float3(0.0, 0.0, 0.0)
	}
	
	
	
	
	
	func distance(to vector: simd_float3) -> SCNFloat
	{
		return simd_float3.distance(from: self, to: vector)
	}
	
	static func distance(from vectorA: simd_float3, to vectorB: simd_float3) -> SCNFloat
	{
		return simd_distance(vectorA, vectorB)
	}
	
	func midPoint(to: simd_float3) -> simd_float3
	{
		let x = (self.x + to.x) / 2.0
		let y = (self.y + to.y) / 2.0
		let z = (self.z + to.z) / 2.0
		
		return simd_float3(x, y, z)
	}
	
	func angle(to vector: simd_float3) -> SCNFloat
	{
		return simd_float3.simd_angle(self, vector)
	}
	
	static func simd_angle(_ vectorA: simd_float3, _ vectorB: simd_float3) -> SCNFloat
	{
		return acos((vectorA ● vectorB) / (vectorA.length * vectorB.length))
	}
	
	func project(onto vector: simd_float3) -> simd_float3
	{
		return simd_project(self, vector)
	}
	
	
	
	
	
	public static func +(lhs: simd_float3, rhs: SCNFloat) -> simd_float3
	{
		return simd_float3(lhs.x + rhs, lhs.y + rhs, lhs.z + rhs)
	}
	
	public static func +=(lhs: inout simd_float3, rhs: SCNFloat)
	{
		lhs = lhs + rhs
	}
	
	public static func +(lhs: SCNFloat, rhs: simd_float3) -> simd_float3
	{
		return rhs + lhs
	}
	
	
	
	
	
	public static func -(lhs: simd_float3, rhs: SCNFloat) -> simd_float3
	{
		return simd_float3(lhs.x - rhs, lhs.y - rhs, lhs.z - rhs)
	}
	
	public static func -=(lhs: inout simd_float3, rhs: SCNFloat)
	{
		lhs = lhs - rhs
	}
	
	public static func -(lhs: SCNFloat, rhs: simd_float3) -> simd_float3
	{
		return rhs - lhs
	}
	
	
	
	
	
	public static func *(lhs: simd_float3, rhs: simd_float4x4) -> simd_float3
	{
		let matrix = SCNMatrix4(rhs)
		return simd_float3(
			lhs.x * matrix.m11 + lhs.y * matrix.m21 + lhs.z * matrix.m31 + matrix.m41,
			lhs.x * matrix.m12 + lhs.y * matrix.m22 + lhs.z * matrix.m32 + matrix.m42,
			lhs.x * matrix.m13 + lhs.y * matrix.m23 + lhs.z * matrix.m33 + matrix.m43
		)
	}
	
	public static func *=(lhs: inout simd_float3, rhs: simd_float4x4)
	{
		lhs = lhs * rhs
	}
	
	public static func *(v: simd_float3, q: simd_quatf) -> simd_float3
	{
		let qv = simd_float3(q.vector.x, q.vector.y, q.vector.z)
		let uv = qv × v
		let uuv = qv × uv
		
		let a = (uv * 2.0 * q.vector.w)
		let b = (uuv * 2.0)
		return v + a + b
	}
	
	public static func *=(lhs: inout simd_float3, q: simd_quatf)
	{
		lhs = lhs * q
	}
	
	
	
	
	
	public static func ●(lhs: simd_float3, rhs: simd_float3) -> SCNFloat
	{
		return simd_dot(lhs, rhs)
	}
	
	public static func ×(lhs: simd_float3, rhs: simd_float3) -> simd_float3
	{
		return simd_cross(lhs, rhs)
	}
}





