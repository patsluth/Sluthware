//
//  FSField.swift
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





public final class FSField<T>
	where T: Codable
{
	public let reference: DocumentReference
	public let fieldName: String
	
	
	
	
	
	internal init(_ document: DocumentReference, _ named: String)
	{
		self.reference = document
		self.fieldName = named
	}
	
	@discardableResult
	public func setValue(_ value: T, _ batch: WriteBatch? = nil) -> Promise<T>
	{
		return Promise { promise in
			do {
				let data = [self.fieldName: try value.encode(Firestore.DataType.self)]
				
				if let batch = batch {
					batch.setData(data, forDocument: self.reference)
					promise.fulfill(value)
				} else {
					self.reference.setData(data) { error in
						if let error = error {
							promise.reject(error)
						} else {
							promise.fulfill(value)
						}
					}
				}
			} catch {
				promise.reject(error)
			}
		}
	}
	
	@discardableResult
	public func delete(_ batch: WriteBatch? = nil) -> Promise<Void>
	{
		return Promise { promise in
			let data = [self.fieldName: FieldValue.delete()]
			
			if let batch = batch {
				batch.setData(data, forDocument: self.reference)
				promise.fulfill()
			} else {
				self.reference.setData(data) { error in
					if let error = error {
						promise.reject(error)
					} else {
						promise.fulfill()
					}
				}
			}
		}
	}
	
	public func valueObservable() -> Observable<ValueResult<T>>
	{
		return Observable.create { observable in
			
			let disposable = self.reference
				.snapshotObservable()
				.subscribe(onNext: { [fieldName = self.fieldName] snapshot in
					let field = snapshot.get(fieldName)
					observable.onNext(ValueResult(field))
				})
			
			return Disposables.create {
				disposable.dispose()
			}
		}
	}
}




