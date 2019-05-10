//
//  URL+Thumbnail.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import AVKit

import PromiseKit
import CancelForPromiseKit





@available(iOS 11.0, *)
enum Thumbnail
{
	static func generateAsync(for url: URL!, size: CGSize) -> CancellablePromise<UIImage?>
	{
		let (promise, resolver) = CancellablePromise<UIImage?>.pending()
		
		DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async(execute: {
			let image = Thumbnail.generate(for: url, size: size)
			DispatchQueue.main.async(execute: {
				if !promise.isCancelled {
					resolver.fulfill(image)
				}
			})
		})
		
		return promise
	}
	
	static func generate(for url: URL!, size: CGSize) -> UIImage?
	{
		guard let url = url else { return nil }
		let mime = Mime(url: url)
		
		if mime.contentType.lowercased().starts(with: "image") {
			if let data = try? Data(contentsOf: url) {
				return UIImage(data: data)
			}
		}

		if let uti = url.uti, AVURLAsset.audiovisualTypes().contains(AVFileType(uti)) {
			return Thumbnail.generateVideo(for: url, size: size)
		} else if AVURLAsset.audiovisualMIMETypes().contains(mime.contentType) {
			return Thumbnail.generateVideo(for: url, size: size)
		}
		
		if mime.contentType.lowercased().contains("pdf") {
			return Thumbnail.generatePDF(for: url, size: size)
		}
		
		return nil
	}
	
	static fileprivate func generateVideo(for url: URL, size: CGSize) -> UIImage?
	{
		let scale = UIScreen.main.scale
		let asset = AVURLAsset(url: url)
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
	
	static fileprivate func generatePDF(for url: URL, size: CGSize) -> UIImage?
	{
		guard let document = CGPDFDocument(url as CFURL) else { return nil }
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




