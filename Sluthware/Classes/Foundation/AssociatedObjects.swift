//
//  AssociatedObjects.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//





public protocol AssociatedObjectIdentifiable
{
	typealias Identifer = UnsafeRawPointer
	
	static var associatedObjectIdentifer: Identifer { get }
	var associatedObjectIdentifer: Identifer { get }
}





public extension AssociatedObjectIdentifiable
{
	// Borrowed from RxSwift, better than using hard coded selectors imo
	static var associatedObjectIdentifer: Identifer {
		let intIdentifier = Int(bitPattern: ObjectIdentifier(Self.self))
		return UnsafeRawPointer(bitPattern: intIdentifier)!
	}

	var associatedObjectIdentifer: Identifer {
		return Self.associatedObjectID
	}
}





extension NSObject: AssociatedObjectIdentifiable
{

}





public extension NSObjectProtocol
{
	public func getAssociatedObject<T>(_ type: T.Type) -> T?
		where T: AssociatedObjectIdentifiable
	{
		return objc_getAssociatedObject(self, type.associatedObjectID) as? T
	}
	
	public func setAssociatedObject<T>(_ object: T?,
									   policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		where T: AssociatedObjectIdentifiable
	{
		objc_setAssociatedObject(self,
								 T.associatedObjectID,
								 nil,
								 policy)
	}
}




