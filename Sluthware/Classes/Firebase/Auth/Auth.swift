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
	public func currentUser(_ refreshToken: Bool = false) -> Observable<User?>
	{
		return Observable.create({ observable in
			
			let listener = self.base.addStateDidChangeListener({ auth, user in
				if let user = user {
					observable.onNext(user)
					//					user.getIDTokenForcingRefresh(true, completion: { token, error in
					//						if let error = error {
					//							print(#file.fileName, #function, error.localizedDescription)
					//						} else {
					//							observable.onNext(user)
					//						}
					//					})
				} else {
					observable.onNext(nil)
				}
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
				} else  {
					let error = error ?? Errors.Message("Login Failed")
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
				} else {
					let error = error ?? Errors.Message("Register Failed")
					if AuthErrorCode(rawValue: error._code) == AuthErrorCode.emailAlreadyInUse {
						self.login(email, password)
							.done({ result in
								resolver.fulfill(result)
							}).catch({ error in
								resolver.reject(error)
							})
					} else {
						resolver.reject(error)
					}
				}
			})
		}
	}
}




