//
//  Auth.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-17.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore
import RxSwift
import RxCocoa
import PromiseKit





public extension Reactive
	where Base: Auth
{
//	public func currentUser(refreshToken: Bool = false) -> Observable<User?>
//	{
//		return Observable.create({ observable in
//
//			let listener = self.base.addStateDidChangeListener({ auth, user in
//				guard let user = user else {
//					observable.onNext(nil)
//					return
//				}
//				guard refreshToken else {
//					observable.onNext(user)
//					return
//				}
//
//				user.authToken(forceRefresh: refreshToken)
//					.done({ _ in
//						observable.onNext(user)
//					})
//					.catch({ _ in
//						observable.onNext(nil)
//					})
//			})
//
//			return Disposables.create {
//				self.base.removeStateDidChangeListener(listener)
//			}
//		}).distinctUntilChanged()
//	}
	
	public func currentUser() -> Observable<User?>
	{
		return Observable.create({ observable in
			
			let listener = self.base.addStateDidChangeListener({ auth, user in
				observable.onNext(user)
			})
			
			return Disposables.create {
				self.base.removeStateDidChangeListener(listener)
			}
		}).distinctUntilChanged()
	}
	
	@discardableResult
	public func login(_ email: String, _ password: String) -> Promise<AuthDataResult>
	{
		return Promise { resolver in
			self.base.signIn(withEmail: email, password: password, completion: { result, error in
				if let result = result {
					resolver.fulfill(result)
				} else if let error = error {
					resolver.reject(error)
				}
			})
		}
	}
	
	@discardableResult
	public func register(_ email: String, _ password: String) -> Promise<AuthDataResult>
	{
		return Promise { resolver in
			self.base.createUser(withEmail: email, password: password, completion: { result, error in
				if let result = result {
					resolver.fulfill(result)
				} else if let error = error {
					if AuthErrorCode(rawValue: error._code) == AuthErrorCode.emailAlreadyInUse {
						self.login(email, password)
							.done({
								resolver.fulfill($0)
							}).catch({
								resolver.reject($0)
							})
					} else {
						resolver.reject(error)
					}
				}
			})
		}
	}
}





public extension User
{
	public func authToken(forceRefresh: Bool = false) -> Promise<String>
	{
		return Promise { resolver in
			self.getIDTokenForcingRefresh(forceRefresh, completion: {
				if let authToken = $0 {
					resolver.fulfill(authToken)
				} else if let error = $1 {
					resolver.reject(error)
				}
			})
		}
	}
	
	public func authTokenResult(forceRefresh: Bool = false) -> Promise<AuthTokenResult>
	{
		return Promise { resolver in
			self.getIDTokenResult(forcingRefresh: forceRefresh, completion: {
				if let authTokenResult = $0 {
					resolver.fulfill(authTokenResult)
				} else if let error = $1 {
					resolver.reject(error)
				}
			})
		}
	}
}




