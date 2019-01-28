//
//  UIBarStyleProvider.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import UIKit





public protocol UIBarStyleProvider
{
	var barTintColor: UIColor? { get }
	var tintColor: UIColor! { get }
	var isTranslucent: Bool { get }
}





extension UINavigationBar: UIBarStyleProvider
{
}

extension UISearchBar: UIBarStyleProvider
{
}

extension UITabBar: UIBarStyleProvider
{
}

extension UIToolbar: UIBarStyleProvider
{
}




