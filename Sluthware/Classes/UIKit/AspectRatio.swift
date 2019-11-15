//
//  AspectRatio.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import UIKit





public enum AspectRatio
{
    case WidthByHeight
    case HeightByWidth
    
    
    
    
    
    public static func widthPercentage(_ size: CGSize!) -> CGFloat
    {
        guard let size = size else { return 0 }
        
        return size.width / size.height
    }
    
    public static func heightPercentage(_ size: CGSize!) -> CGFloat
    {
        guard let size = size else { return 0 }
        
        return size.height / size.width
    }
}





public extension AspectRatio
{
    class ImageView: UIImageView
    {
        public var type = AspectRatio.WidthByHeight {
            didSet { self.invalidateIntrinsicContentSize() }
        }
        
        public override var image: UIImage? {
            didSet { self.invalidateIntrinsicContentSize() }
        }
        
        public override var intrinsicContentSize: CGSize {
            var size = self.bounds.size
            
            switch self.type {
            case .WidthByHeight:
                size.height = size.width * AspectRatio.heightPercentage(self.image?.size)
            case .HeightByWidth:
                size.width = size.height * AspectRatio.widthPercentage(self.image?.size)
            }
            
            return size
        }
        
        
        
        
        
        public override init(frame: CGRect)
        {
            super.init(frame: frame)
            
            self.contentMode = .scaleAspectFit
            
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





