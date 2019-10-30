//
//  UIImage+Resize.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-20.
//

import AVKit
import Foundation
import CoreGraphics





@available(iOS 10.0, *)
public extension UIImage
{
    /// Create new image with size
    func imageResizedTo(_ targetSize: CGSize) -> UIImage
    {
        guard !self.size.equalTo(targetSize) else { return self }
        
        let fittedRect = AVMakeRect(
            aspectRatio: self.size,
            insideRect: CGRect(origin: .zero, size: targetSize)
        )
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image(actions: { context in
            self.draw(in: fittedRect)
        })
        //        return UIGraphicsImageRenderer(size: targetSize).image(actions: { _ in
        //            self.draw(in: CGRect(origin: .zero, size: targetSize))
        //        })
        
        
        
        //        guard let imageRef = self.cgImage else { return self }
        //        let newRect = CGRect(origin: CGPoint.zero, size: newSize).integral
        //
        //        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        //        defer { UIGraphicsEndImageContext() }
        //
        //        guard let context = UIGraphicsGetCurrentContext() else { return self }
        //
        //        // Set the quality level to use when rescaling
        //        context.interpolationQuality = CGInterpolationQuality.high
        //        let verticalFlipTransform = CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: -1.0, tx: 0.0, ty: newSize.height)
        //
        //        context.concatenate(verticalFlipTransform)
        //        // Draw into the context; this scales the image
        //        context.draw(imageRef, in: newRect)
        //
        //        // Get the resized image from the context and a UIImage
        //        guard let newImageRef = context.makeImage() else { return self }
        //
        //        return UIImage(cgImage: newImageRef) ?? self
    }
}




