//
//  FSDocument.swift
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





public final class FSDocument<T>: Codable
	where T: Codable
{
	public typealias FSValueType = DocumentSnapshot.FSValueType<T>
	
	
	
	
	
	public let path: String
	public var reference: DocumentReference {
		return Firestore.firestore().document(self.path)
	}
	
	
	
	
	
	internal init(_ reference: DocumentReference)
	{
		self.path = reference.path
	}
	
	@discardableResult
	public func setValue(_ value: T, _ batch: WriteBatch? = nil) -> Promise<T>
	{
		return Promise { promise in
			do {
				let data = try value.encode(Firestore.DataType.self)
				
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
			if let batch = batch {
				batch.deleteDocument(self.reference)
				promise.fulfill()
			} else {
				self.reference.delete(completion: { error in
					if let error = error {
						promise.reject(error)
					} else {
						promise.fulfill()
					}
				})
			}
		}
	}
	
	public func valueObservable() -> Observable<FSValueType>
	{
		return Observable.create { observable in
			
			let disposable = self.reference
				.snapshotObservable()
				.subscribe(onNext: { snapshot in
					do {
						observable.onNext(try snapshot.decodeValue())
					} catch {
						observable.onError(error)
					}
				})
			
			return Disposables.create {
				disposable.dispose()
			}
		}
	}
}




