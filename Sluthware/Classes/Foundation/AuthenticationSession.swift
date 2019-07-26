//
//  AuthenticationSession.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-07-19.
//  Copyright © 2017 patsluth. All rights reserved.
//

import UIKit
import Foundation
import SafariServices
import AuthenticationServices

import CancelForPromiseKit





/// PromiseKit wrapper for
/// SFAuthenticationSession and ASWebAuthenticationSession
/// depeneding on iOS version
@available(iOS 11.0, *)
public enum AuthenticationSession
{
	static func start(url: URL, callbackURLScheme: String?) -> CancellablePromise<URL>
	{
		if #available(iOS 12.0, *) {
			return self._start(ASWebAuthenticationSession.self,
							   url: url,
							   callbackURLScheme: callbackURLScheme)
		} else {
			return self._start(SFAuthenticationSession.self,
							   url: url,
							   callbackURLScheme: callbackURLScheme)
		}
	}
	
	private static func _start<T>(_ type: T.Type,
								  url: URL,
								  callbackURLScheme: String?) -> CancellablePromise<URL>
		where T: SFAuthenticationSession
	{
		let (promise, resolver) = CancellablePromise<URL>.pending()
		let session = T(url: url, callbackURLScheme: callbackURLScheme) {
			if let url = $0 {
				resolver.fulfill(url)
			} else {
				resolver.reject($1 ?? PMKError.cancelled)
			}
		}
		
		promise.appendCancellableTask(task: CancellableFunction({
			session.cancel()
		}), reject: nil)
		
		session.start()
		
		return promise
	}
	
	@available(iOS 12.0, *)
	private static func _start<T>(_ type: T.Type,
								  url: URL,
								  callbackURLScheme: String?) -> CancellablePromise<URL>
		where T: ASWebAuthenticationSession
	{
		let (promise, resolver) = CancellablePromise<URL>.pending()
		
		let session = T(url: url, callbackURLScheme: callbackURLScheme) {
			if let url = $0 {
				resolver.fulfill(url)
			} else {
				resolver.reject($1 ?? PMKError.cancelled)
			}
		}
		if #available(iOS 13.0, *) {
			session.presentationContextProvider = UIApplication.shared
		}
		
		promise.appendCancellableTask(task: CancellableFunction({
			session.cancel()
		}), reject: nil)
		
		session.start()
		
		return promise
	}
}





@available(iOS 13.0, *)
extension UIApplication: ASWebAuthenticationPresentationContextProviding
{
	public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor
	{
		return self.keyWindow ?? ASPresentationAnchor()
	}
}




