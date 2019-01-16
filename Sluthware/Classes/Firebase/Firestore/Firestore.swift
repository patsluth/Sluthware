//
//  Firestore.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import FirebaseFirestore
import RxSwift
import RxCocoa
import PromiseKit





internal extension Firestore
{
	typealias DataType = [String: Any]
}





public extension Query
{
	public func snapshotPromise() -> Promise<QuerySnapshot>
	{
		return Promise { resolver in
			self.getDocuments(completion: { snapshot, error in
				if let snapshot = snapshot {
					resolver.fulfill(snapshot)
				} else if let error = error {
					resolver.reject(error)
				}
			})
		}
	}
	
	public func snapshotObservable() -> Observable<QuerySnapshot>
	{
		return Observable.create { observable in
			let listener = self.addSnapshotListener({ snapshot, error in
				if let snapshot = snapshot {
					observable.onNext(snapshot)
				} else if let error = error {
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
		where T: Codable
	{
		return FirestoreDocument<T>(self.document(named))
	}
	
	public func asCollectionOf<T>(_ type: T.Type) -> FirestoreCollection<T>
		where T: Codable
	{
		return FirestoreCollection<T>(self)
	}
}





public extension DocumentReference
{
	public func asDocumentOf<T>(_ type: T.Type) -> FirestoreDocument<T>
		where T: Codable
	{
		return FirestoreDocument<T>(self)
	}
	
	public func collectionOf<T>(_ type: T.Type,
								_ named: String = "\(T.self)s".lowercased()) -> FirestoreCollection<T>
		where T: Codable
	{
		return FirestoreCollection<T>(self, named)
	}
	
	public func fieldOf<T>(_ type: T.Type,
						   _ named: String = "\(T.self)".lowercased()) -> FirestoreField<T>
		where T: Codable
	{
		return FirestoreField<T>(self, named)
	}
	
	public func snapshotPromise() -> Promise<DocumentSnapshot>
	{
		return Promise { resolver in
			
			self.getDocument(completion: { snapshot, error in
				if let snapshot = snapshot {
					resolver.fulfill(snapshot)
				} else if let error = error {
					resolver.reject(error)
				}
			})
		}
	}
	
	public func snapshotObservable() -> Observable<DocumentSnapshot>
	{
		return Observable.create { observable in
			
			let listener = self.addSnapshotListener({ snapshot, error in
				if let error = error {
					observable.onError(error)
				} else if let snapshot = snapshot {
					observable.onNext(snapshot)
				}
			})
			
			return Disposables.create() {
				listener.remove()
			}
		}
	}
	
	public func fieldObservable<V>(fieldName: String, _ type: V.Type) -> Observable<V?>
	{
		return Observable.create { observable in
			
			let disposable = self
				.snapshotObservable()
				.subscribe(onNext: { snapshot in
					let field = snapshot.get(fieldName) as? V
					observable.onNext(field)
				})
			
			return Disposables.create {
				disposable.dispose()
			}
		}
	}
	
	public func fieldObservable<V>(fieldName: String, defaultValue: V) -> Observable<V>
	{
		return self.fieldObservable(fieldName: fieldName, V.self)
			.map({ value in
				return value ?? defaultValue
			})
	}
}





public extension QuerySnapshot
{
	public typealias Value<T> = [DocumentChange.Value<T>]
		where T: Codable
	
	func decodeValues<T>() -> Value<T>
		where T: Codable
	{
		return self.documentChanges.map({
			$0.decodeValue()
		})
	}
}





public extension DocumentChange
{
	public typealias Value<T> = (change: DocumentChange, snapshot: DocumentSnapshot.Value<T>)
		where T: Codable
	
	public func decodeValue<T>() -> Value<T>
		where T: Codable
	{
		return (change: self, snapshot: self.document.decodeValue())
	}
}





public extension DocumentSnapshot
{
	public typealias Value<T> = (document: FirestoreDocument<T>, result: ValueResult<T>)
		where T: Codable
	
	public func decodeValue<T>() -> Value<T>
		where T: Codable
	{
		let document = FirestoreDocument<T>(self.reference)
		let result = ValueResult<T>(self.data())
		return (document: document, result: result)
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
					resolver.fulfill()
				}
			})
		}
	}
}




