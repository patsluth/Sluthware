//
//  Firestore.swift
//  Sluthwarec
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore
import RxSwift
import RxCocoa
import PromiseKit





public extension Firestore
{
	public typealias DataType = [String: Any]
	public typealias ModelType = Codable & Equatable
}





public extension Query
{
	public func snapshotPromise(source: FirestoreSource = .default) -> Promise<QuerySnapshot>
	{
		return Promise { resolver in
			self.getDocuments(source: source, completion: { snapshot, error in
				switch ValueResult(snapshot, error)! {
				case .Success(let value):
					resolver.fulfill(value)
				case .Failure(let error):
					resolver.reject(error)
				}
			})
		}
	}
	
	public func snapshotObservable(includeMetadataChanges changes: Bool = false) -> Observable<QuerySnapshot>
	{
		return Observable.create { observable in
			let listener = self.addSnapshotListener(includeMetadataChanges: changes, listener: { snapshot, error in
				switch ValueResult(snapshot, error)! {
				case .Success(let value):
					observable.onNext(value)
				case .Failure(let error):
					observable.onError(error)
				}
			})
			
			return Disposables.create() {
				listener.remove()
			}
		}
	}
}





public extension CollectionReference
{
	public func documentOf<T>(_ type: T.Type,
							  _ named: String = "\(T.self)".lowercased()) -> FirestoreDocument<T>
		where T: Firestore.ModelType
	{
		return FirestoreDocument<T>(self.document(named))
	}
	
	public func asCollectionOf<T>(_ type: T.Type) -> FirestoreCollection<T>
		where T: Firestore.ModelType
	{
		return FirestoreCollection<T>(self)
	}
}





public extension DocumentReference
{
	public func asDocumentOf<T>(_ type: T.Type) -> FirestoreDocument<T>
		where T: Firestore.ModelType
	{
		return FirestoreDocument<T>(self)
	}
	
	public func collectionOf<T>(_ type: T.Type,
								_ named: String = "\(T.self)s".lowercased()) -> FirestoreCollection<T>
		where T: Firestore.ModelType
	{
		return FirestoreCollection<T>(self, named)
	}
	
	public func fieldOf<T>(_ type: T.Type,
						   _ named: String = "\(T.self)".lowercased()) -> FirestoreField<T>
		where T: Firestore.ModelType
	{
		return FirestoreField<T>(self, named)
	}
	
	public func snapshotPromise(source: FirestoreSource = .default) -> Promise<DocumentSnapshot>
	{
		return Promise { resolver in
			self.getDocument(source: source, completion: { snapshot, error in
				switch ValueResult(snapshot, error)! {
				case .Success(let value):
					resolver.fulfill(value)
				case .Failure(let error):
					resolver.reject(error)
				}
			})
		}
	}
	
	public func snapshotObservable(includeMetadataChanges changes: Bool = false) -> Observable<DocumentSnapshot>
	{
		return Observable.create { observable in
			let listener = self.addSnapshotListener(includeMetadataChanges: changes, listener: { snapshot, error in
				switch ValueResult(snapshot, error)! {
				case .Success(let value):
					observable.onNext(value)
				case .Failure(let error):
					observable.onError(error)
				}
			})
			
			return Disposables.create() {
				listener.remove()
			}
		}
	}
}





public extension QuerySnapshot
{
	public typealias Value<T> = [DocumentChange.Value<T>]
		where T: Firestore.ModelType
	
	func decodeValues<T>() -> Value<T>
		where T: Firestore.ModelType
	{
		return self.documentChanges.map({
			$0.decodeValue()
		})
	}
}





public extension DocumentChange
{
	public typealias Value<T> = (change: DocumentChange, snapshot: DocumentSnapshot.Value<T>)
		where T: Firestore.ModelType
	
	public func decodeValue<T>() -> Value<T>
		where T: Firestore.ModelType
	{
		return (change: self,
				snapshot: self.document.decodeValue())
	}
}





public extension DocumentSnapshot
{
	public typealias Value<T> = (document: FirestoreDocument<T>, result: ValueResult<T>)
		where T: Firestore.ModelType
	
	public func decodeValue<T>() -> Value<T>
		where T: Firestore.ModelType
	{
		return (document: FirestoreDocument<T>(self.reference),
				result: ValueResult<T>(self.data()))
	}
}





public extension WriteBatch
{
	@discardableResult
	public func commitPromise() -> Promise<Void>
	{
		return Promise { resolver in
			self.commit(completion: { error in
				if let error = error {
					resolver.reject(error)
				} else {
					resolver.fulfill(())
				}
			})
		}
	}
}





public extension User
{
	public var document: DocumentReference {
		return Firestore.firestore()
			.collection("users")
			.document(self.uid)
	}
}




