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
	
	
	
	
	
	public lazy var embedded: T! = {
		T.make({
			self.selectionStyle = .none
			
			self.contentView.addSubview($0)
		}).make(constraints: {
			$0.edges.equalTo(self.contentView.snp.margins)
		})
	}()
	
	
	
	
	
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




