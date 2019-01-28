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
	public var ref: DocumentReference {
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
					batch.setData(data, forDocument: self.ref)
					resolver.fulfill(self)
				} else {
					self.ref.setData(data) { error in
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
				batch.deleteDocument(self.ref)
				resolver.fulfill(self)
			} else {
				self.ref.delete(completion: { error in
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
		return self.ref
			.snapshotPromise(source: source)
			.map({ snapshot in
				snapshot.decodeValue()
			})
	}
	
	public func valueObservable(includeMetadataChanges changes: Bool = false) -> Observable<Value>
	{
		return Observable.create { observable in
			
			let disposable = self.ref
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




