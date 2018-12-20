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
		let f = Fraction(num: 4, den: 8)
		//for i in stride(from: 0.25, to: 2.0, by: 0.15) {
		print(Fraction(0.25))
		print(Fraction(1.5, precision: 9))
		//}
		
		
		print(try? UIColor.red.getRGBA())
		var a = [1, 2, 3]
		print(a.indices.contains(2))
		print(a.indices.contains(3))
		print(a.indices.contains(4))
		
		print((0..<a.endIndex).clamp(10))
		a.remove(at: (0..<a.endIndex).clamp(10))
		a.insert(5, at: a.indices.clamp(10))
//
		//application.initializeSciChart()
		print(UIColor.red.toHex())
		print(UIColor.clear.toHex())
		print(UIColor().toHex())
		print(UIColor(hex: "0xE62121"))
		let i = Int("00FF0000")
		print(0x00FF0000, String(format: "%02X%02X", 0x00FF0000))
		
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




