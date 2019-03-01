//
//  AssociatedObject.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//





public enum AssociatedObject
{
	public typealias Identifer = UnsafeRawPointer
	
	public static func identifer<T>(_ type: T.Type) -> Identifer
	{
		let intIdentifier = Int(bitPattern: ObjectIdentifier(T.self))
		return UnsafeRawPointer(bitPattern: intIdentifier)!
	}
	
	public static func identifer<T>(_ object: T) -> Identifer
	{
		return AssociatedObject.identifer(T.self)
	}
}





//public extension AssociatedObjectIdentifiable
//{
//	// Borrowed from RxSwift, better than using hard coded selectors imo
//	static var associatedObjectIdentifer: Identifer {
//		let intIdentifier = Int(bitPattern: ObjectIdentifier(Self.self))
//		return UnsafeRawPointer(bitPattern: intIdentifier)!
//	}
//
//	var associatedObjectIdentifer: Identifer {
//		return Self.associatedObjectIdentifer
//	}
//}




//
//extension NSObject: AssociatedObjectIdentifiable
//{
//
//}





public extension NSObjectProtocol
{
	public func getAssociatedObject<T>(_ identifier: AssociatedObject.Identifer, _ type: T.Type) -> T?
	{
		return objc_getAssociatedObject(self, identifier) as? T
	}
	
	public func getAssociatedObject<T>(_ type: T.Type) -> T?
	{
		let identifier = AssociatedObject.identifer(type)
		
		return self.getAssociatedObject(identifier, type)
	}
	
	
	
	public func setAssociatedObject<T>(_ object: T?,
									   _ identifier: AssociatedObject.Identifer,
									   policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	{
		objc_setAssociatedObject(self,
								 identifier,
								 object,
								 policy)
	}
	
	public func setAssociatedObject<T>(_ object: T?,
									   policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	{
		let identifier = AssociatedObject.identifer(object)
		
		self.setAssociatedObject(object, identifier)
	}
}




