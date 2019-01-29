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
	public typealias QueryProvider = (CollectionReference) -> Query
	
	
	
	
	
	public let ref: CollectionReference
	
	
	
	
	
	internal init(_ collection: CollectionReference)
	{
		self.ref = collection
	}
	
	internal init(_ document: DocumentReference, _ named: String)
	{
		self.ref = document.collection(named)
	}
	
	@discardableResult
	public func addDocument(with value: T) -> Promise<FirestoreDocument<T>>
	{
		return Promise { resolver in
			do {
				let data = try value.encode(Firestore.DataType.self)
				let document = self.ref.addDocument(data: data)
				resolver.fulfill(document.asDocumentOf(T.self))
			} catch {
				resolver.reject(error)
			}
		}
	}
	
//	@discardableResult
//	public func addDocument(with value: T, named: String) -> Promise<FirestoreDocument<T>>
//	{
//		return Promise { resolver in
//			do {
//				let data = try value.encode(Firestore.DataType.self)
//				let document = self.collection.documentOf(T.self, named)
//				document.setValue(value)
//				.done({ document in
//					resolver.fulfill(document)
//				})
//				.catch({ error in
//					resolver.reject(error)
//				})
//			} catch {
//				resolver.reject(error)
//			}
//		}
//	}
	
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
	
	public func observable(includeMetadataChanges changes: Bool = true) -> Observable<Value>
	{
		return self.observable(includeMetadataChanges: changes, queryProvider: {
			$0
		})
	}
	
	public func observable(includeMetadataChanges changes: Bool = true,
						   queryProvider: @escaping QueryProvider) -> Observable<Value>
	{
		return Observable.create { observable in
			
			let disposable = queryProvider(self.ref)
				// TODO: Add to input params
				.snapshotObservable(includeMetadataChanges: changes)
				.subscribe(onNext: { snapshot in
					observable.onNext(snapshot.decodeValues())
				})
			
			return Disposables.create {
				disposable.dispose()
			}
		}
	}
}




