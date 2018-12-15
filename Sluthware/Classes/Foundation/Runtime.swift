//
//  Runtime.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public final class Runtime
{
	public enum Errors: Error
	{
		case Swizzle(Selector)
	}
	
	
	
	
	
	private init()
	{
		
	}
	
	public class func swizzle<T>(_ type: T.Type,
								 _ originalSelector: Selector,
								 _ swizzledSelector: Selector) throws
		where T: AnyObject
	{
		guard let originalMethod = class_getInstanceMethod(T.self, originalSelector) else {
			throw Runtime.Errors.Swizzle(originalSelector)
		}
		guard let swizzledMethod = class_getInstanceMethod(T.self, swizzledSelector) else {
			throw Runtime.Errors.Swizzle(swizzledSelector)
		}
		
		let didAddMethod = class_addMethod(T.self,
										   originalSelector,
										   method_getImplementation(swizzledMethod),
										   method_getTypeEncoding(swizzledMethod))
		
		if didAddMethod {
			class_replaceMethod(T.self,
								swizzledSelector,
								method_getImplementation(originalMethod),
								method_getTypeEncoding(originalMethod))
		} else {
			method_exchangeImplementations(originalMethod, swizzledMethod)
		}
	}
}




