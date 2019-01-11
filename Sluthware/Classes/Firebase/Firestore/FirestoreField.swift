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
	where T: Codable
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
				let data = [self.name: try value.encode(Firestore.DataType.self)]
				
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
	
	public func observable() -> Observable<ValueResult<T>>
	{
		return Observable.create { [fieldName = self.name] observable in
			
			let disposable = self.document
				.snapshotObservable()
				.subscribe(onNext: { snapshot in
					let field = snapshot.get(fieldName)
					observable.onNext(ValueResult(field))
				})
			
			return Disposables.create {
				disposable.dispose()
			}
		}
	}
}




