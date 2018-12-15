//
//  SCNMaterial.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit





public extension SCNMaterial
{
	class func constantLitWith(color: UIColor) -> SCNMaterial
	{
		let material = SCNMaterial()
		
		material.diffuse.contents = color
		material.isDoubleSided = true
		material.ambient.contents = UIColor.black
		material.lightingModel = SCNMaterial.LightingModel.constant
		material.emission.contents = color
		
		return material
	}
}




