//
// 	UITableViewHeaderFooterWithEmbeddedContentView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit

import SnapKit





public extension NSObjectProtocol
	where Self: UIView
{
	typealias TVReusableView = UITableViewHeaderFooterWithEmbeddedContentView<Self>
}





public class UITableViewHeaderFooterWithEmbeddedContentView<T>: UITableView.BaseHeaderFooterView, UIViewWithEmbeddedContent
	where T: UIView
{
	public typealias Embedded = T
	
	
	
	
	
	public var embedded: T!
	
	
	
	
	
	public override init(reuseIdentifier: String?)
	{
		super.init(reuseIdentifier: reuseIdentifier)
		
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
	
	required init?(coder aDecoder: NSCoder)
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




