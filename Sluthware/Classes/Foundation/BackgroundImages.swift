//
//  BackgroundImages.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-03-01.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public final class BackgroundImages
{
	public typealias FilePath = String
	public typealias ImageName = String
	fileprivate typealias Image = (width: Int, height: Int, aspectRatio: CGFloat, filePath: FilePath)
	fileprivate typealias Images = [Image]
	fileprivate typealias ImageDataSource = (fullScreen: Images, other: Images)
	
	
	
	
	
	fileprivate let imagesByImageName: [ImageName: ImageDataSource]
	
	
	
	
	
	public init(directoryURL: URL?) throws
	{
		let fm = FileManager.default
		var imagesByImageName = [ImageName: ImageDataSource]()
		
		
		
		guard let directoryPath = directoryURL?.resolvingSymlinksInPath().path else { throw Errors.Init }
		let subDirectoryPaths = try fm.contentsOfDirectory(atPath: directoryPath)
		
		for subDirectoryPath in subDirectoryPaths {
			
			let imageName = subDirectoryPath.fileName
			let subDirectoryPath = directoryPath + "/" + imageName
			let fullScreenDirectoryPath = subDirectoryPath + "/" + "FullScreen"
			let otherDirectoryPath = subDirectoryPath + "/" + "Other"
			
			func imagesFor(directoryPath: String) -> Images?
			{
				guard let fileNames = try? fm.contentsOfDirectory(atPath: directoryPath) else { return nil }
				
				var images = Images()
				
				for fileName in fileNames {
					
					let filePath = directoryPath + "/" + fileName
					let fileURL = URL(fileURLWithPath: filePath) as CFURL
					guard let imageSource = CGImageSourceCreateWithURL(fileURL, nil) else { continue }
					guard let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [CFString: Any] else { continue }
					guard let imageWidth = imageProperties[kCGImagePropertyPixelWidth] as? Int else { continue }
					guard let imageHeight = imageProperties[kCGImagePropertyPixelHeight] as? Int else { continue }
					let imageAspectRatio = CGFloat(imageWidth) / CGFloat(imageHeight)
					
					images.append(Image(width: imageWidth,
										height: imageHeight,
										aspectRatio: imageAspectRatio,
										filePath: filePath))
				}
				
				return images
			}
			
			guard let fullScreenImages = imagesFor(directoryPath: fullScreenDirectoryPath) else { continue }
			guard let otherImages = imagesFor(directoryPath: otherDirectoryPath) else { continue }
			
			let imageDataSource = (fullScreen: fullScreenImages, other: otherImages)
			imagesByImageName.updateValue(imageDataSource, forKey: imageName)
		}
		
		
		
		self.imagesByImageName = imagesByImageName
	}
	
	public subscript(name name: BackgroundImages.ImageName, size size: CGSize) -> FilePath?
	{
		#if os(iOS)

		guard let imageDataSource = self.imagesByImageName[name] else { return nil }
		guard let keyWindow = UIApplication.shared.keyWindow else { return nil }
		let isFullScreen = (size == keyWindow.bounds.size)
		let images = (isFullScreen) ? imageDataSource.fullScreen : imageDataSource.other
		
		let width = Int(size.width)
		let height = Int(size.height)
		let targetAspectRatio = CGFloat(width) / CGFloat(height)
		var closest = (aspectRatio: CGFloat.greatestFiniteMagnitude, index: -1)
		
		for (index, image) in images.enumerated() {
			//			if UIDevice.current.orientation.isLandscape {
			//				guard image.width > image.height else { continue }
			//			} else {
			//				guard image.width < image.height else { continue }
			//			}
			if image.width == width && image.height == height {
				closest.index = index
				break
			}
			//			guard image.aspectRatio != targetAspectRatio else { return image.filePath }
			
			let aspectRatioDifference = abs(targetAspectRatio - image.aspectRatio)
			if aspectRatioDifference < closest.aspectRatio {
				closest.aspectRatio = aspectRatioDifference
				closest.index = index
			}
		}
		
		let filePath = images[safe: closest.index]?.filePath
		
		return filePath
		
		#else
		
		return nil
		
		#endif
	}
}




