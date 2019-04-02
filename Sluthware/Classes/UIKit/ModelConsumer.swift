//
//  ModelConsumer.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit





public protocol ModelConsumer
{
	associatedtype Model
	
	var model: Model! { get set }
}





//public typealias ModelViewController = UIViewController & ModelConsumer
//public typealias ModelView = UIView & ModelConsumer
public protocol ModelViewController: ModelConsumer
	where Self: UIViewController
{
	
}

public extension ModelConsumer
	where Self: NSObject
{
	init(model: Model)
	{
		self.init()
		
		self.model = model
	}
}
//
//
//
//
//
public protocol ModelView: ModelConsumer
	where Self: UIView
{
	//	associatedtype Model
	//
	//	func update(with model: Model)
}





public extension UITableView
{
	public typealias ModelCell = UITableViewCell & ModelView
	//	public typealias SelectableModelCell = UITableView.ModelCell & SelectableModelViewProtocol
}





public extension UICollectionView
{
	public typealias ModelCell = UICollectionViewCell & ModelView
	//	public typealias SelectableModelCell = UICollectionView.ModelCell & SelectableModelViewProtocol
}




