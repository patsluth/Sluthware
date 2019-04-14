//
//  AspectRatio.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import UIKit





public enum AspectRatio
{
	case WH
	case HW
}





public extension AspectRatio
{
	open class ImageView: UIImageView
	{
		public var type = AspectRatio.WH {
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
			
			switch self.type {
			case .WH:
				if let image = self.image {
					aspectRato = image.size.height / image.size.width
				}
				size.height(size.width * aspectRato)
			case .HW:
				if let image = self.image {
					aspectRato = image.size.width / image.size.height
				}
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





