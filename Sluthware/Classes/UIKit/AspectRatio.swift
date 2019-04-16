//
//  AspectRatio.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import UIKit





public enum AspectRatio
{
	case WidthToHeight
	case HeightToWidth
}





public extension AspectRatio
{
	open class ImageView: UIImageView
	{
		public var type = AspectRatio.WidthToHeight {
			didSet { self.invalidateIntrinsicContentSize() }
		}
		
		open override var image: UIImage? {
			didSet
			{
				self.contentMode = UIView.ContentMode.scaleAspectFit
				self.invalidateIntrinsicContentSize()
			}
		}
		
		open override var intrinsicContentSize: CGSize {
			var size = self.bounds.size
			var aspectRato: CGFloat = 0
			
			guard let image = self.image else { return size }
			
			switch self.type {
			case .WidthToHeight:
				let aspectRato = image.size.height / image.size.width
				size.height(size.width * aspectRato)
			case .HeightToWidth:
				let aspectRato = image.size.width / image.size.height
				size.width(size.height * aspectRato)
			}
			
			return size
		}
		
		
		
		
		
		public override init(frame: CGRect)
		{
			super.init(frame: frame)
			
			defer {
				self.image = { self.image }()
			}
		}
		
		required public init?(coder aDecoder: NSCoder)
		{
			super.init(coder: aDecoder)
		}
		
		open override func awakeFromNib()
		{
			super.awakeFromNib()
			
			self.image = { self.image }()
		}
		
		open override func layoutSubviews()
		{
			super.layoutSubviews()
			
			self.invalidateIntrinsicContentSize()
		}
	}
}





