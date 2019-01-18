//
//  FirestoreCollection.swift
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





public final class FirestoreCollection<T>
	where T: Firestore.ModelType
{
	public typealias Value = QuerySnapshot.Value<T>
	
	
	
	
	
	public let collection: CollectionReference
	
	
	
	
	
	internal init(_ collection: CollectionReference)
	{
		self.collection = collection
	}
	
	internal init(_ document: DocumentReference, _ named: String)
	{
		self.collection = document.collection(named)
	}
	
	@discardableResult
	public func addDocument(with value: T) -> Promise<FirestoreDocument<T>>
	{
		return Promise { resolver in
			do {
				let data = try value.encode(Firestore.DataType.self)
				let document = self.collection.addDocument(data: data)
				resolver.fulfill(document.asDocumentOf(T.self))
			} catch {
				resolver.reject(error)
			}
		}
	}
	
//	@discardableResult
//	public func addDocument(with value: T) -> Promise<FirestoreDocument<T>>
//	{
//		return Promise { resolver in
//			do {
//				let data = try value.encode(Firestore.DataType.self)
//
//				let document = self.reference.addDocument(data: data, completion: { error in
//					if let error = error {
//						resolver.reject(error)
//					}
//				})
//			} catch {
//				resolver.reject(error)
//			}
//		}
//	}
	
	public func observable() -> Observable<Value>
	{
		return self.observable(queryBuilder: { $0 })
	}
	
	public func observable(queryBuilder: @escaping (CollectionReference) -> Query) -> Observable<Value>
	{
		return Observable.create { observable in
			
			let disposable = queryBuilder(self.collection)
				.snapshotObservable()
				.subscribe(onNext: { snapshot in
					observable.onNext(snapshot.decodeValues())
				})
			
			return Disposables.create {
				disposable.dispose()
			}
		}
	}
}




