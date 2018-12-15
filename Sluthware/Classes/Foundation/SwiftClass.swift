//
//  SwiftClass.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public func SwiftClassFromString(_ classString: String) -> AnyClass?
{
	if let classValue = NSClassFromString(classString) {
		return classValue
	}
	
	return NSClassFromString(StringFromSwiftClassString(classString))
}

public func StringFromSwiftClassString(_ classString: String) -> String
{
	guard let object = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") else { return classString }
	guard let applicationName = object as? String else { return classString }
	
	return String(format: "_TtC%lu%@%lu%@",
				  UInt32(applicationName.count),
				  applicationName,
				  UInt32(classString.count),
				  classString)
}




