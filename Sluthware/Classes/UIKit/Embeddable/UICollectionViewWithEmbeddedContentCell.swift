//
//  UICollectionViewWithEmbeddedContentCell.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit

import SnapKit





public extension NSObjectProtocol
	where Self: UIView
{
	typealias CVCell = UICollectionViewWithEmbeddedContentCell<Self>
}





public class UICollectionViewWithEmbeddedContentCell<T>: UICollectionView.BaseCell, UIViewWithEmbeddedContent
	where T: UIView
{
	public typealias Embedded = T
	public typealias PreferredLayoutAttributesProvider = (UICollectionViewWithEmbeddedContentCell<T>, UICollectionViewLayoutAttributes) -> Void
	
	
	
	
	
	public lazy var embedded: T! = {
		T.make({
			self.contentView.addSubview($0)
		}).make(constraints: {
			$0.edges.equalTo(self.contentView.snp.margins)
		})
	}()
	
	private var preferredLayoutAttributesProvider: PreferredLayoutAttributesProvider? = nil
	
	
	
	
	
	@discardableResult
	public func preferredLayoutAttributes(provider: @escaping PreferredLayoutAttributesProvider) -> Self
	{
		self.preferredLayoutAttributesProvider = provider
		return self
	}
	
	public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes
	{
		let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
		
		//		let size = self.contentView.systemSize(fitting: attributes.size)
		////		let size = self.contentView.systemSize(horizontal: .required, vertical: .required)
		//		attributes.size = size
		
		self.preferredLayoutAttributesProvider?(self, attributes)
		
		return attributes
	}
	
	public override func prepareForReuse()
	{
		super.prepareForReuse()
		
		self.preferredLayoutAttributesProvider = nil
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




