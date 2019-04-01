//
//  UIImage+Resize.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-20.
//

import Foundation
import CoreGraphics





public extension UIImage
{
	public func resizedTo(width: CGFloat) -> UIImage
	{
		let height = (width / self.size.width) * self.size.height
		
		return self.resizedTo(CGSize(width: width, height: height))
	}
	
	public func resizedTo(height: CGFloat) -> UIImage
	{
		let width = (height / self.size.height) * self.size.width
		
		return self.resizedTo(CGSize(width: width, height: height))
	}
	
	public func resizedTo(_ newSize: CGSize) -> UIImage
	{
		guard self.size != newSize else { return self }
		
		guard let imageRef = self.cgImage else { return self }
		let newRect = CGRect(origin: CGPoint.zero, size: newSize).integral
		
		UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
		defer { UIGraphicsEndImageContext() }
		
		guard let context = UIGraphicsGetCurrentContext() else { return self }
		
		// Set the quality level to use when rescaling
		context.interpolationQuality = CGInterpolationQuality.high
		let verticalFlipTransform = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: -1.0, tx: 0.0, ty: newSize.height)
		
		context.concatenate(verticalFlipTransform)
		// Draw into the context; this scales the image
		context.draw(imageRef, in: newRect)
		
		// Get the resized image from the context and a UIImage
		guard let newImageRef = context.makeImage() else { return self }
		
		return UIImage(cgImage: newImageRef) ?? self
	}
}




