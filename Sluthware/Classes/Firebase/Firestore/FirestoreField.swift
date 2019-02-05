//
//  FirestoreField.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import FirebaseFirestore
import RxSwift
import RxCocoa
import RxSwiftExt
import PromiseKit





public final class FirestoreField<T>
	where T: Firestore.ModelType
{
	public let ref: DocumentReference
	public let name: String
	
	
	
	
	
	internal init(_ document: DocumentReference, _ named: String)
	{
		self.ref = document
		self.name = named
	}
	
	@discardableResult
	public func set(value: T, _ batch: WriteBatch? = nil) -> Promise<FirestoreField<T>>
	{
		return Promise { resolver in
			do {
				let data = try [self.name: value].encode(Firestore.DataType.self)
				
				if let batch = batch {
					batch.setData(data, forDocument: self.ref)
					resolver.fulfill(self)
				} else {
					self.ref.setData(data, merge: true, completion: { error in
						if let error = error {
							resolver.reject(error)
						} else {
							resolver.fulfill(self)
						}
					})
				}
			} catch {
				resolver.reject(error)
			}
		}
	}
	
	@discardableResult
	public func delete(_ batch: WriteBatch? = nil) -> Promise<FirestoreField<T>>
	{
		return Promise { resolver in
			
			let data = [self.name: FieldValue.delete()]
			
			if let batch = batch {
				batch.updateData(data, forDocument: self.ref)
				resolver.fulfill(self)
			} else {
				self.ref.updateData(data) { error in
					if let error = error {
						resolver.reject(error)
					} else {
						resolver.fulfill(self)
					}
				}
			}
		}
	}
	
	public func valuePromise(source: FirestoreSource = .default) -> Promise<T>
	{
		return self.ref
			.snapshotPromise(source: source)
			.map({ snapshot in
				snapshot.get(self.name)
			})
			.map({ field in
				try T.decode(field)
				//ValueResult(field)
			})
	}
	
	public func valueObservable(includeMetadataChanges changes: Bool = true) -> Observable<ValueResult<T>>
	{
		return self.ref
			.snapshotObservable(includeMetadataChanges: changes)
			.map({ snapshot in
				snapshot.get(self.name)
			})
			.map({ field in
				ValueResult(field)
			})
	}
}




