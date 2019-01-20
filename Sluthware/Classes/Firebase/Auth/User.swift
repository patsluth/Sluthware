//
//  User.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-17.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import FirebaseAuth
import PromiseKit





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




