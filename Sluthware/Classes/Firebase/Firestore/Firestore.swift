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
		return Promise { promise in
			self.getDocuments(completion: { snapshot, error in
				if let snapshot = snapshot {
					promise.fulfill(snapshot)
				} else if let error = error {
					promise.reject(error)
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
							  _ named: String = "\(T.self)".lowercased()) -> FSDocument<T>
		where T: Codable
	{
		return FSDocument<T>(self.document(named))
	}
	
	public func asCollectionOf<T>(_ type: T.Type) -> FSCollection<T>
		where T: Codable
	{
		return FSCollection<T>(self)
	}
}





public extension DocumentReference
{
	public func asDocumentOf<T>(_ type: T.Type) -> FSDocument<T>
		where T: Codable
	{
		return FSDocument<T>(self)
	}
	
	public func collectionOf<T>(_ type: T.Type,
								_ named: String = "\(T.self)s".lowercased()) -> FSCollection<T>
		where T: Codable
	{
		return FSCollection<T>(self, named)
	}
	
	public func fieldOf<T>(_ type: T.Type,
						   _ named: String = "\(T.self)".lowercased()) -> FSField<T>
		where T: Codable
	{
		return FSField<T>(self, named)
	}
	
	public func snapshotPromise() -> Promise<DocumentSnapshot>
	{
		return Promise { promise in
			
			self.getDocument(completion: { snapshot, error in
				if let snapshot = snapshot {
					promise.fulfill(snapshot)
				} else if let error = error {
					promise.reject(error)
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
}





public extension QuerySnapshot
{
	public typealias FSValueType<T> = [DocumentChange.FSValueType<T>]
		where T: Codable
	
	func decodeValues<T>() -> FSValueType<T>
		where T: Codable
	{
		return self.documentChanges.map({
			$0.decodeValue()
		})
	}
}





public extension DocumentChange
{
	public typealias FSValueType<T> = (change: DocumentChange, snapshot: DocumentSnapshot.FSValueType<T>)
		where T: Codable
	
	public func decodeValue<T>() -> FSValueType<T>
		where T: Codable
	{
		return (change: self, snapshot: self.document.decodeValue())
	}
}





public extension DocumentSnapshot
{
	public typealias FSValueType<T> = (document: FSDocument<T>, result: ValueResult<T>)
		where T: Codable
	
	public func decodeValue<T>() -> FSValueType<T>
		where T: Codable
	{
		let document = FSDocument<T>(self.reference)
		let result = ValueResult<T>(self.data())
		return (document: document, result: result)
	}
}





public extension WriteBatch
{
	@discardableResult
	public func commitPromise() -> Promise<Void>
	{
		return Promise { promise in
			self.commit(completion: { error in
				if let error = error {
					promise.reject(error)
				} else {
					promise.fulfill()
				}
			})
		}
	}
}




