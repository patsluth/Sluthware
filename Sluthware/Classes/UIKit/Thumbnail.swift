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
import Kingfisher





@available(iOS 11.0, *)
public enum Thumbnail
{
	public enum GenerationError: Error
	{
		case InvalidURL
		case Failed
	}
	
	public typealias Output = Swift.Result<Kingfisher.Image, GenerationError>
	
	
	
	/// Attempts to generate thumbnail for URL. Supports image, video and pdf types
	public static func generateAsync(for url: URL!,
									 size: CGSize,
									 useCache: Bool = true) -> CancellableGuarantee<Output>
	{
		let (guarantee, resolver) = CancellableGuarantee<Output>.pending()
		let cache = ImageCache.default
		let cacheKey = "\(Thumbnail.self)_\(url.absoluteString)"
		
		let task = DispatchWorkItem(qos: .background, flags: .enforceQoS, block: {
			func _generate() -> Output
			{
				return Thumbnail.generateFor(anyURL: url, size: size)
			}
			
			/// cache.retrieveImage can still complete if the task is cancelled,
			/// so this ensures the output will only be sent if it needs to be
			func _resolve(_ output: Output)
			{
				if guarantee.isPending && !guarantee.isCancelled {
					resolver(output)
				}
			}
			
			guard useCache else {
				_resolve(_generate())
				return
			}
			
            cache.retrieveImage(forKey: cacheKey, completionHandler: {
                if let image = try? $0.get().image {
					_resolve(.success(image))
					return
				}
				
				let output = _generate()
				do {
					cache.store(try output.get(),
								original: nil,
								forKey: cacheKey,
								options: KingfisherParsedOptionsInfo(nil),
								toDisk: true,
								completionHandler: nil)
				} catch {
					cache.removeImage(forKey: cacheKey)
				}
				
				_resolve(output)
			})
		})
		
		guarantee.appendCancellableTask(task: task, reject: nil)
		
		DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
			.async(execute: task)
		
		return guarantee
	}
	
	/// Attempts to generate thumbnail for URL. Supports image, video and pdf types
	public static func generateFor(anyURL url: URL!,
								   size: CGSize) -> Output
	{
		guard let url = url else {
			return .failure(GenerationError.InvalidURL)
		}
		
		if let image = try? Thumbnail.generateFor(imageURL: url, size: size).get() {
			return .success(image)
		}
		if let image = try? Thumbnail.generateFor(videoURL: url, size: size).get() {
			return .success(image)
		}
		if let image = try? Thumbnail.generateFor(pdfURL: url, size: size).get() {
			return .success(image)
		}
		
		return .failure(GenerationError.Failed)
	}
	
	static func generateFor(imageURL url: URL,
							size: CGSize) -> Output
	{
		guard url.mime.contentType.lowercased().starts(with: "image") else {
			return .failure(GenerationError.InvalidURL)
		}
		
		guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
			return .failure(GenerationError.Failed)
		}
		
		return .success(image)
	}
	
	static func generateFor(videoURL url: URL,
							size: CGSize,
							at seconds: Double = 1) -> Output
	{
		if let uti = url.uti, AVURLAsset.audiovisualTypes().contains(AVFileType(uti)) {
			// continue
		} else if AVURLAsset.audiovisualMIMETypes().contains(url.mime.contentType) {
			// continue
		} else {
			return .failure(GenerationError.InvalidURL)
		}
		
		let scale = UIScreen.main.scale
		let asset = AVURLAsset(url: url)
		let generator = AVAssetImageGenerator(asset: asset)
		generator.appliesPreferredTrackTransform = true
		generator.maximumSize = size * scale
		
		let timescale: Int32 = 1000
		let atTime = CMTime(seconds: seconds, preferredTimescale: timescale)
		var actualTime = CMTime(seconds: seconds, preferredTimescale: timescale)
		
		guard let cgImage = try? generator.copyCGImage(at: atTime, actualTime: &actualTime) else {
			return .failure(GenerationError.Failed)
		}
		
		return .success(UIImage(cgImage: cgImage, scale: scale, orientation: .up))
	}
	
	static func generateFor(pdfURL url: URL,
							size: CGSize,
							page: UInt = 1) -> Output
	{
		guard url.mime.contentType.lowercased().contains("pdf"),
			let page = CGPDFDocument(url as CFURL)?.page(at: Int(page)) else {
				return .failure(GenerationError.InvalidURL)
		}
		
		let scale = UIScreen.main.scale
		let originalPageRect: CGRect = page.getBoxRect(.mediaBox)
		var targetPageRect = AVMakeRect(aspectRatio: originalPageRect.size,
										insideRect: CGRect(origin: CGPoint.zero, size: size))
		targetPageRect.origin = CGPoint.zero
		
		UIGraphicsBeginImageContextWithOptions(targetPageRect.size, true, 0.0)
		
		guard let context = UIGraphicsGetCurrentContext() else {
			return .failure(GenerationError.Failed)
		}
		
		context.setFillColor(UIColor.clear.cgColor)		// Transparent background
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
		
		guard let cgImage = context.makeImage() else {
			return .failure(GenerationError.Failed)
		}
		
		return .success(UIImage(cgImage: cgImage, scale: scale, orientation: .up))
	}
}




