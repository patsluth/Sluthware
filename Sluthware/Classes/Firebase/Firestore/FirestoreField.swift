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
	public let document: DocumentReference
	public let name: String
	
	
	
	
	
	internal init(_ document: DocumentReference, _ named: String)
	{
		self.document = document
		self.name = named
	}
	
	@discardableResult
	public func set(value: T, _ batch: WriteBatch? = nil) -> Promise<FirestoreField<T>>
	{
		return Promise { resolver in
			do {
				let data = try [self.name: value].encode(Firestore.DataType.self)
				
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
	public func delete(_ batch: WriteBatch? = nil) -> Promise<FirestoreField<T>>
	{
		return Promise { resolver in
			
			let data = [self.name: FieldValue.delete()]
			
			if let batch = batch {
				batch.updateData(data, forDocument: self.document)
				resolver.fulfill(self)
			} else {
				self.document.updateData(data) { error in
					if let error = error {
						resolver.reject(error)
					} else {
						resolver.fulfill(self)
					}
				}
			}
		}
	}
	
	public func valuePromise(source: FirestoreSource = .default) -> Promise<ValueResult<T>>
	{
		return self.document
			.snapshotPromise(source: source)
			.map({ snapshot in
				snapshot.get(self.name)
			})
			.map({ field in
				ValueResult(field)
			})
	}
	
	public func valueObservable(includeMetadataChanges changes: Bool = false) -> Observable<ValueResult<T>>
	{
		return self.document
			.snapshotObservable(includeMetadataChanges: changes)
			.map({ snapshot in
				snapshot.get(self.name)
			})
			.map({ field in
				ValueResult(field)
			})
			.distinctUntilChanged()
	}
}




