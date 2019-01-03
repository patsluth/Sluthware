//
//  AppDelegate.swift
//  Sluthware
//
//  Created by patsluth on 12/19/2017.
//  Copyright (c) 2017 patsluth. All rights reserved.
//

import UIKit

@_exported import Sluthware





@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
	var window: UIWindow?
	
	
	
	
	
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
	{
		let a = Fraction(2, 1)
		let b = Fraction(14, 29)
		print((a - b).asMixedNumber())
//		print(5.0 < Double.nan)
//		print(5.0 < Double.infinity)
		
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




