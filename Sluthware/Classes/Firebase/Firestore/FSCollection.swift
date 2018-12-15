//
//  FSCollection.swift
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





public final class FSCollection<T>
	where T: Codable
{
	public typealias FSValueType = QuerySnapshot.FSValueType<T>
	
	
	
	
	
	public let reference: CollectionReference
	
	
	
	
	
	internal init(_ reference: CollectionReference)
	{
		self.reference = reference
	}
	
	internal init(_ document: DocumentReference, _ named: String)
	{
		self.reference = document.collection(named)
	}
	
	@discardableResult
	public func addDocument(with value: T) -> Promise<Void>
	{
		return Promise { promise in
			do {
				let data = try value.encode(Firestore.DataType.self)
				
				self.reference.addDocument(data: data, completion: { error in
					if let error = error {
						promise.reject(error)
					} else {
						promise.fulfill()
					}
				})
			} catch {
				promise.reject(error)
			}
		}
	}
	
	public func valueObservable() -> Observable<FSValueType>
	{
		return self.valueObservable(queryBuilder: { $0 })
	}
	
	public func valueObservable(queryBuilder: @escaping (CollectionReference) -> Query) -> Observable<FSValueType>
	{
		return Observable.create { observable in
			
			let disposable = queryBuilder(self.reference)
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




