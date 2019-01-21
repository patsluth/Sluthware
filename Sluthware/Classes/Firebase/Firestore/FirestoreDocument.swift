//
//  FirestoreDocument.swift
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





public final class FirestoreDocument<T>: Codable
	where T: Firestore.ModelType
{
	public typealias Value = DocumentSnapshot.Value<T>
	
	
	
	
	
	public let path: String
	public var document: DocumentReference {
		return Firestore.firestore().document(self.path)
	}
	
	
	
	
	
	internal init(_ document: DocumentReference)
	{
		self.path = document.path
	}
	
	@discardableResult
	public func setValue(_ value: T, _ batch: WriteBatch? = nil) -> Promise<FirestoreDocument<T>>
	{
		return Promise { resolver in
			do {
				let data = try value.encode(Firestore.DataType.self)
				
				if let batch = batch {
					batch.setData(data, forDocument: self.document)
					resolver.fulfill(self)
				} else {
					self.document.setData(data) { error in
						if let error = error {
							resolver.reject(error)
						} else {
							resolver.fulfill(self)
						}
					}
				}
			} catch {
				resolver.reject(error)
			}
		}
	}
	
	@discardableResult
	public func delete(_ batch: WriteBatch? = nil) -> Promise<FirestoreDocument<T>>
	{
		return Promise { resolver in
			if let batch = batch {
				batch.deleteDocument(self.document)
				resolver.fulfill(self)
			} else {
				self.document.delete(completion: { error in
					if let error = error {
						resolver.reject(error)
					} else {
						resolver.fulfill(self)
					}
				})
			}
		}
	}
	
	public func valuePromise(source: FirestoreSource = .default) -> Promise<Value>
	{
		return self.document
			.snapshotPromise(source: source)
			.map({ snapshot in
				snapshot.decodeValue()
			})
	}
	
	public func valueObservable(includeMetadataChanges changes: Bool = false) -> Observable<Value>
	{
		return Observable.create { observable in
			
			let disposable = self.document
				.snapshotObservable(includeMetadataChanges: changes)
				.subscribe(onNext: { snapshot in
					observable.onNext(snapshot.decodeValue())
				})
			
			return Disposables.create {
				disposable.dispose()
			}
		}
	}
}




