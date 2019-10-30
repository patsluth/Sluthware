//
//  UITableViewWithEmbeddedContentCell.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit

import SnapKit





public extension NSObjectProtocol
	where Self: UIView
{
	typealias TVCell = UITableViewWithEmbeddedContentCell<Self>
}





public class UITableViewWithEmbeddedContentCell<T>: UITableView.BaseCell, UIViewWithEmbeddedContent
	where T: UIView
{
	public typealias Embedded = T
	
	
	
	
	
	public var embedded: T!
	
	public override var isSelected: Bool {
		didSet
		{
			(self.embedded as? SelectableViewProtocol)?.isSelected = self.isSelected
		}
	}
	
	public override var isHighlighted: Bool {
		didSet
		{
			(self.embedded as? HighlightableViewProtocol)?.isHighlighted = self.isHighlighted
		}
	}
	
	
	
	
	
	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
	{
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.selectionStyle = .none
		
		if let nib = (T.self as? NibProvider.Type)?.nib,
			let nibView = nib.instantiate(withOwner: nil, options: nil).first as? T {
			self.embedded = nibView
		} else {
			self.embedded = T.make()
		}
		
		self.contentView.addSubview(self.embedded)
		self.embedded.make(constraints: {
			$0.edges.equalTo(self.contentView)
		})
		
		self.backgroundColor = nil
	}
	
	public required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
	}
	
	public override func prepareForReuse()
	{
		super.prepareForReuse()
		
		(self.embedded as? UIReusableViewProtocol)?.prepareForReuse()
	}
	
	public override func prepareForInterfaceBuilder()
	{
		super.prepareForInterfaceBuilder()
		
		self.embedded.prepareForInterfaceBuilder()
	}
	
	deinit
	{
		self.prepareForReuse()
	}
}




