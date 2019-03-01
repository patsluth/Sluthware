//
//  ModelView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit





public protocol ModelView
	where Self: UIView
{
	associatedtype Model
	
	static var nib: UINib? { get }
	
	func update(with model: Model)
}





public extension UITableView
{
	public typealias ModelCell = UITableViewCell & ModelViewProtocol
//	public typealias SelectableModelCell = UITableView.ModelCell & SelectableModelViewProtocol
}





public extension UICollectionView
{
	public typealias ModelCell = UICollectionViewCell & ModelViewProtocol
//	public typealias SelectableModelCell = UICollectionView.ModelCell & SelectableModelViewProtocol
}




