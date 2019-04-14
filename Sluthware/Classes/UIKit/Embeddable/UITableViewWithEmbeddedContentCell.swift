//
//  UITableViewWithEmbeddedContentCell.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit

import SnapKit





public extension UIEmbeddableContentView
{
	typealias TVCell = UITableViewWithEmbeddedContentCell<Self>
}





public class UITableViewWithEmbeddedContentCell<T>: UITableViewCell, UIViewWithEmbeddedContent
	where T: UIEmbeddableContentView
{
	public typealias Embedded = T
	
	
	
	
	
	public lazy var embedded: T = {
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
		
		self.embedded.prepareForReuse?()
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





extension UITableViewWithEmbeddedContentCell: ModelConsumer
	where Embedded: ModelConsumer
{
	public typealias Model = Embedded.Model
	
	public var model: Embedded.Model! {
		get { return self.embedded.model }
		set { self.embedded.model = newValue }
	}
}




