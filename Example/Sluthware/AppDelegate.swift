//
//  AppDelegate.swift
//  Sluthware
//
//  Created by patsluth on 12/19/2017.
//  Copyright (c) 2017 patsluth. All rights reserved.
//

import UIKit

@_exported import Sluthware


open class TEST
{
	typealias X = Int
	
	init(a: String){
		print(X.self)
	}
}

class TEST2: TEST
{
	typealias X = UIView
	
	private override init(a: String)
	{
		print(X.self)
		super.init(a: a)
	}
	
	convenience init()
	{
		self.init(a: "A")
	}
}




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?
	
	
	struct TestD: Codable {
		let a: String
		let b: Int
	}
	
	
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
	{
		TEST.init(a: "YYYr")
		TEST2.init()
		let a = "PAT"// as Any
		do {
			print(try ["test": a].encode([String: Any].self))
			print(try ["test2": TestD.init(a: "P", b: 7)].encode([String: Any].self))
		} catch {
			print(error)
		}
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication)
	{
	}
	
	func applicationDidEnterBackground(_ application: UIApplication)
	{
	}
	
	func applicationWillEnterForeground(_ application: UIApplication)
	{
	}
	
	func applicationDidBecomeActive(_ application: UIApplication)
	{
	}
	
	func applicationWillTerminate(_ application: UIApplication)
	{
	}
}




