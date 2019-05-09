//
//  URL+Thumbnail.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import AVKit





@available(iOS 11.0, *)
public extension URL
{
	func generateThumbnailFor(size: CGSize) -> UIImage?
	{
		if self.isFileTypeOf("pdf") {
			return self.generatePDFThumbnail(forSize: size)
		} else if self.isAVPlayable {
			return self.generateVideoThumbnail(forSize: size)
		}
		
		return nil
	}
	
	fileprivate func generateVideoThumbnail(forSize size: CGSize) -> UIImage?
	{
		let scale = UIScreen.main.scale
		let asset = AVURLAsset(url: self)
		let generator = AVAssetImageGenerator(asset: asset)
		generator.appliesPreferredTrackTransform = true
		generator.maximumSize = CGSize(width: size.width * scale, height: size.height * scale)
		
		let kPreferredTimescale: Int32 = 1000
		var actualTime: CMTime = CMTime(seconds: 0, preferredTimescale: kPreferredTimescale)
		//generates thumbnail at first second of the video
		let cgImage = try? generator.copyCGImage(at: CMTime(seconds: 1, preferredTimescale: kPreferredTimescale),
												 actualTime: &actualTime)
		return cgImage.flatMap {
			UIImage(cgImage: $0, scale: scale, orientation: UIImage.Orientation.up)
		}
	}
	
	fileprivate func generatePDFThumbnail(forSize size: CGSize) -> UIImage?
	{
		guard let document = CGPDFDocument(self as CFURL) else { return nil }
		guard let page = document.page(at: 1) else { return nil }
		
		let originalPageRect: CGRect = page.getBoxRect(.mediaBox)
		var targetPageRect = AVMakeRect(aspectRatio: originalPageRect.size,
										insideRect: CGRect(origin: CGPoint.zero, size: size))
		targetPageRect.origin = CGPoint.zero
		
		UIGraphicsBeginImageContextWithOptions(targetPageRect.size, true, 0.0)
		
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		
		context.setFillColor(gray: 1.0, alpha: 1.0)
		context.fill(targetPageRect)
		
		context.saveGState()
		context.translateBy(x: 0.0, y: targetPageRect.height)
		context.scaleBy(x: 1.0, y: -1.0)
		context.concatenate(page.getDrawingTransform(CGPDFBox.mediaBox,
													 rect: targetPageRect,
													 rotate: 0,
													 preserveAspectRatio: true))
		context.drawPDFPage(page)
		context.restoreGState()
		
		UIGraphicsEndImageContext()
		
		return context.makeImage().flatMap {
			UIImage(cgImage: $0, scale: UIScreen.main.scale, orientation: UIImage.Orientation.up)
		}
	}
}




