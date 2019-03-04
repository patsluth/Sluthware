//
//  NSObjectProtocol+AssociatedObject.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//





//public enum AssociatedObject
//{
//	case Of(T.Type)
//	case Named(String)
//
//	fileprivate var identifier: UnsafeRawPointer {
//		switch self {
//		case .Of(let type):
//			let intIdentifier = Int(bitPattern: ObjectIdentifier(T.self))
//			return UnsafeRawPointer(bitPattern: intIdentifier)!
//		case .Named(let name):
//			var a = Selector(name)
//		}
//	}
//
////	public static func identifer<T>(_ type: T.Type) -> Identifer
////	{
////		let intIdentifier = Int(bitPattern: ObjectIdentifier(T.self))
////		return UnsafeRawPointer(bitPattern: intIdentifier)!
////	}
////
////	public static func identifer<T>(_ object: T) -> Identifer
////	{
////		return AssociatedObject.identifer(T.self)
////	}
//}





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
	
	
	// Uses unique key based on type
	//	public func getAssociatedObject<T>(_ type: T.Type) -> T?
	//	{
	//		let identifier = AssociatedObject.identifer(type)
	//
	//		return self.getAssociatedObject(identifier, type)
	//	}
	//
	//	public func getAssociatedObject<T>(_ type: T.Type) -> T?
	//	{
	//		let identifier = AssociatedObject.identifer(type)
	//
	//		return self.getAssociatedObject(identifier, type)
	//	}
	
	
	
	//	public func setAssociatedObject<T>(_ object: T?,
	//									   _ identifier: AssociatedObject.Identifer,
	//									   policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	//	{
	//		objc_setAssociatedObject(self,
	//								 identifier,
	//								 object,
	//								 policy)
	//	}
	
	public func get<T>(associatedObject named: String,
					   _ type: T.Type) -> T?
	{
		let key = UnsafeRawPointer(bitPattern: named.hash)!
		
		return objc_getAssociatedObject(self, key) as? T
	}
	
	public func set<T>(associatedObject named: String,
					   object: T?,
					   policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
	{
		let key = UnsafeRawPointer(bitPattern: named.hash)!
		
		objc_setAssociatedObject(self, key, object, policy)
	}
}




