//
//  UIViewWithEmbeddedContent.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit





public protocol UIViewWithEmbeddedContent: UIView
{
	associatedtype Embedded: UIView
	
	
	
	var embedded: Embedded { get set }
}




