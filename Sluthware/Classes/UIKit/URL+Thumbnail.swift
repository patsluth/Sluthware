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
    }
    
    
    
    
    
    /// Attempts to generate thumbnail 'targetSize'
    /// Supports image, video and pdf urls
    func generateThumbnail(targetSize: CGSize,
                           usingCache: Bool = true) -> CancellablePromise<KFCrossPlatformImage>
    {
        let (promise, resolver) = CancellablePromise<KFCrossPlatformImage>.pending()
        let cache = ImageCache.default
        let cacheKey = "\(self.absoluteString)_thumb_\(targetSize.width)x\(targetSize.height)"
        
        let task = DispatchWorkItem(qos: .background, flags: .enforceQoS, block: {
            
            /// cache.retrieveImage can still complete if the task is cancelled,
            /// so this ensures the output will only be sent if it needs to be
            if !usingCache {
                cache.removeImage(forKey: cacheKey)
            }
            
            cache.retrieveImage(forKey: cacheKey, options: nil, completionHandler: {
                
                // cache.retrieveImage can still complete if the task is cancelled,
                // so this ensures the output will only be sent if it needs to be
                guard promise.isPending && !promise.isCancelled else { return }
                
                if let image = try? $0.get().image {
                    resolver.fulfill(image)
                    return
                }
                
                do {
                    let image = try self.generateThumbnailSync(targetSize: targetSize)
                    cache.store(image,
                                original: nil,
                                forKey: cacheKey,
                                options: KingfisherParsedOptionsInfo(nil),
                                toDisk: true,
                                completionHandler: nil)
                    resolver.fulfill(image)
                } catch {
                    resolver.reject(error)
                }
            })
        })
        
        promise.appendCancellableTask(task: task, reject: nil)
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
            .async(execute: task)
        
        return promise
    }
    
    /// Attempts to generate thumbnail for URL. Supports image, video and pdf types
    func generateThumbnailSync(targetSize: CGSize) throws -> KFCrossPlatformImage
    {
        if self.isImageURL {
            return try self.generateImageThumbnailSync(targetSize: targetSize)
        }
        if self.isVideoURL {
            return try self.generateVideoThumbnailSync(targetSize: targetSize)
        }
        if self.isPDFURL {
            return try self.generatePDFThumbnailSync(targetSize: targetSize)
        }
        
        throw GenerateThumbnailError.Failed
    }
    
    func generateImageThumbnailSync(targetSize: CGSize) throws -> KFCrossPlatformImage
    {
        guard self.isImageURL else {
            throw GenerateThumbnailError.InvalidURL(message: "Invalid Image URL")
        }
        
        guard let data = try? Data(contentsOf: self), let image = UIImage(data: data) else {
            throw GenerateThumbnailError.Failed
        }
        
        return image
            .imageResizedTo(targetSize)
    }
    
    func generateVideoThumbnailSync(targetSize: CGSize,
                                    at seconds: Double = 1) throws -> KFCrossPlatformImage
    {
        guard self.isVideoURL else {
            throw GenerateThumbnailError.InvalidURL(message: "Invalid Video URL")
        }
        
        let asset = AVURLAsset(url: self)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = targetSize * UIScreen.main.scale
        
        let timescale: Int32 = 1000
        let atTime = CMTime(seconds: seconds, preferredTimescale: timescale)
        var actualTime = CMTime(seconds: seconds, preferredTimescale: timescale)
        
        let cgImage = try generator.copyCGImage(at: atTime, actualTime: &actualTime)
        
        return UIImage(
            cgImage: cgImage,
            scale: UIScreen.main.scale,
            orientation: .up
        ).imageResizedTo(targetSize)
    }
    
    func generatePDFThumbnailSync(targetSize: CGSize,
                                  page: UInt = 1) throws-> KFCrossPlatformImage
    {
        guard self.isPDFURL,
            let page = CGPDFDocument(self as CFURL)?.page(at: Int(page)) else {
                throw GenerateThumbnailError.InvalidURL(message: "Invalid PDF URL")
        }
        
        let scale = UIScreen.main.scale
        let originalPageRect = page.getBoxRect(.mediaBox)
        var targetPageRect = AVMakeRect(
            aspectRatio: originalPageRect.size,
            insideRect: CGRect(origin: CGPoint.zero, size: targetSize)
        )
        targetPageRect.origin = CGPoint.zero
        
        UIGraphicsBeginImageContextWithOptions(targetPageRect.size, true, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            throw GenerateThumbnailError.Failed
        }
        
        context.setFillColor(UIColor.clear.cgColor)        // Transparent background
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
            throw GenerateThumbnailError.Failed
        }
        
        return UIImage(
            cgImage: cgImage,
            scale: scale,
            orientation: .up
        ).imageResizedTo(targetSize)
    }
}




