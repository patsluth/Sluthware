//
//  UIEmbeddableContentView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit





public protocol HighlightableViewProtocol: UIView
{
	var isHighlighted: Bool { get set }
	
	//	func setHighlighted(_ highlighted: Bool, animated: Bool)
}





public protocol SelectableViewProtocol: UIView
{
	var isSelected: Bool { get set }
	
	//	func setSelected(_ selected: Bool, animated: Bool)
}

extension UITableViewCell: SelectableViewProtocol, HighlightableViewProtocol
{
}

extension UICollectionViewCell: SelectableViewProtocol, HighlightableViewProtocol
{
}

extension UIImageView: HighlightableViewProtocol
{
}





@objc public protocol UIEmbeddedContentView
	where Self: UIView
{
	@objc optional func prepareForReuse()
}




