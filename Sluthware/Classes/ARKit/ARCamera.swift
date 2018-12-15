//
//  ARCamera.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit
import ARKit





@available(iOS 11.0, *)
public extension ARCamera
{
	var worldPosition: simd_float3 {
		return self.transform.translation
	}
}




