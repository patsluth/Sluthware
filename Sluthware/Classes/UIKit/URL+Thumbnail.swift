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





@available(iOS 10.0, *)
public extension URL
{
    enum GenerateThumbnailError: Error
    {
        case InvalidURL(message: String)
        case Failed
        case ProcessorFailed(unprocessed: KFCrossPlatformImage)
    }
    
    private static let thumbnailOperationQueue: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 10
        operationQueue.qualityOfService = .background
        return operationQueue
    }()
    
    
    
    /// Attempts to generate thumbnail 'targetSize'
    /// Supports image, video and pdf urls
    func generateThumbnail(usingCache: Bool = true,
                           processor: ImageProcessor? = nil) -> CancellablePromise<KFCrossPlatformImage>
    {
        let cache = ImageCache.default
        let thumbnailCacheKey = "\(self.fileNameFull)_thumb_\(processor?.identifier ?? "unprocessed")"
        let (promise, resolver) = CancellablePromise<KFCrossPlatformImage>.pending()
        
        if !usingCache {
            cache.removeImage(forKey: thumbnailCacheKey)
        }
        
        let operation = BlockOperation()
        operation.addExecutionBlock({ [unowned operation] in
            guard !operation.isCancelled else { return }
            do {
                let image = try self.generateThumbnailSync(processor: processor)
                
                cache.store(image,
                            forKey: thumbnailCacheKey,
                            options: KingfisherParsedOptionsInfo(nil),
                            toDisk: true)
                
                resolver.fulfill(image)
            } catch {
                resolver.reject(error)
            }
        })
        
        promise.appendCancellableTask(task: CancellableFunction({ [weak operation] in
            operation?.cancel()
        }), reject: nil)
        
        cache.retrieveImage(forKey: thumbnailCacheKey, options: nil, completionHandler: {
            guard promise.isPending && !promise.isCancelled else { return }
            
            if let image = try? $0.get().image {
                resolver.fulfill(image)
            } else {
                Self.thumbnailOperationQueue.addOperation(operation)
            }
        })
        
        return promise
    }
    
    /// Attempts to generate thumbnail for URL. Supports image, video and pdf types
    func generateThumbnailSync(processor: ImageProcessor? = nil) throws -> KFCrossPlatformImage
    {
        switch self {
        case let url where url.isImageURL:
            return try self.generateImageThumbnailSync(processor: processor)
        case let url where url.isVideoURL:
            return try self.generateVideoThumbnailSync(processor: processor)
        case let url where url.isPDFURL:
            return try self.generatePDFThumbnailSync(processor: processor)
        default:
            throw GenerateThumbnailError.InvalidURL(message: "Invalid URL")
        }
    }
    
    func generateImageThumbnailSync(processor: ImageProcessor? = nil) throws -> KFCrossPlatformImage
    {
        guard self.isImageURL else {
            throw GenerateThumbnailError.InvalidURL(message: "Invalid Image URL")
        }
        
        guard let data = try? Data(contentsOf: self), let image = UIImage(data: data) else {
            throw GenerateThumbnailError.Failed
        }
        
        return try self._process(unprocessed: image, processor: processor)
    }
    
    func generateVideoThumbnailSync(at seconds: Double = 1,
                                    processor: ImageProcessor? = nil) throws -> KFCrossPlatformImage
    {
        guard self.isVideoURL else {
            throw GenerateThumbnailError.InvalidURL(message: "Invalid Video URL")
        }
        
        let asset = AVURLAsset(url: self)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        if let track = asset.tracks(withMediaType: .video).first {
            generator.maximumSize = track.naturalSize * UIScreen.main.scale
        }
        
        let timescale: Int32 = 1000
        let atTime = CMTime(seconds: seconds, preferredTimescale: timescale)
        var actualTime = CMTime(seconds: seconds, preferredTimescale: timescale)
        
        let cgImage = try generator.copyCGImage(at: atTime, actualTime: &actualTime)
        let image = UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        
        return try self._process(unprocessed: image, processor: processor)
    }
    
    func generatePDFThumbnailSync(page: UInt = 1,
                                  processor: ImageProcessor? = nil) throws-> KFCrossPlatformImage
    {
        guard self.isPDFURL, let page = CGPDFDocument(self as CFURL)?.page(at: Int(page)) else {
            throw GenerateThumbnailError.InvalidURL(message: "Invalid PDF URL")
        }
        
        let rect = page.getBoxRect(.mediaBox)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            throw GenerateThumbnailError.Failed
        }
        
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(rect)
        
        context.saveGState()
        context.translateBy(x: 0.0, y: rect.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.concatenate(page.getDrawingTransform(CGPDFBox.mediaBox,
                                                     rect: rect,
                                                     rotate: 0,
                                                     preserveAspectRatio: true))
        context.drawPDFPage(page)
        context.restoreGState()
        
        UIGraphicsEndImageContext()
        
        guard let cgImage = context.makeImage() else {
            throw GenerateThumbnailError.Failed
        }
        
        let image = UIImage(cgImage: cgImage, scale: UIScreen.main.scale, orientation: .up)
        
        return try self._process(unprocessed: image, processor: processor)
    }
    
    private func _process(unprocessed image: UIImage,
                          processor: ImageProcessor?) throws -> KFCrossPlatformImage {
        guard var processor = processor else { return image }
        if let resizingProcessor = processor as? ResizingImageProcessor {
            if resizingProcessor.referenceSize.equalTo(.zero) {
                processor = ResizingImageProcessor(
                    referenceSize: image.size,
                    mode: resizingProcessor.targetContentMode
                )
            }
        }
        let options = KingfisherParsedOptionsInfo(nil)
        guard let processed = processor.process(item: .image(image), options: options) else {
            throw GenerateThumbnailError.ProcessorFailed(unprocessed: image)
        }
        return processed
    }
}




