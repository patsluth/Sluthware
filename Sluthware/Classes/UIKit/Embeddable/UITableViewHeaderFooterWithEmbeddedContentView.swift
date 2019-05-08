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
	
	
	
	
	
	public lazy var embedded: T = {
		T.make({
			self.contentView.addSubview($0)
		}).make(constraints: {
			$0.edges.equalTo(self.contentView.snp.margins)
		})
	}()
	
	
	
	
	
	public override init(reuseIdentifier: String?)
	{
		super.init(reuseIdentifier: reuseIdentifier)
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




