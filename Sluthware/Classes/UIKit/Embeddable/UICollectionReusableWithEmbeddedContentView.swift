//
//  UICollectionReusableWithEmbeddedContentView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit

import SnapKit





public extension NSObjectProtocol
	where Self: UIView
{
	typealias CVReusableView = UICollectionReusableWithEmbeddedContentView<Self>
}





public class UICollectionReusableWithEmbeddedContentView<T>: UICollectionReusableView, UIViewWithEmbeddedContent
	where T: UIView
{
	public typealias Embedded = T
	public typealias PreferredLayoutAttributesProvider = (UICollectionReusableWithEmbeddedContentView<T>, UICollectionViewLayoutAttributes) -> Void
	
	
	
	
	
	public lazy var embedded: T = {
		T.make({
			self.addSubview($0)
		}).make(constraints: {
			$0.edges.equalTo(self.snp.margins)
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
		(self.embedded as? UIEmbeddableContentView)?.prepareForReuse?()
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





extension UICollectionReusableWithEmbeddedContentView: ModelConsumer
	where T: ModelConsumer
{
	public typealias Model = T.Model
	
	public var model: T.Model! {
		get { return self.embedded.model }
		set { self.embedded.model = newValue }
	}
}




