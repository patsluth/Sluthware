//
//  UIViewWithEmbeddedContent.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit





public protocol UIViewWithEmbeddedContent
	where Self: UIView
{
	associatedtype Embedded: UIEmbeddableContentView
	
	
	
	var embedded: Embedded { get set }
}




