//
//  URL+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import AVKit
import Foundation





public extension URL
{
	var uti: String? {
		return (try? self.resourceValues(forKeys: [URLResourceKey.typeIdentifierKey]))?.typeIdentifier
	}
	
	func isFileTypeOf(_ pathExtension: String) -> Bool
	{
		guard self.isFileURL else { return false }
		return (self.pathExtension.lowercased() == pathExtension.lowercased())
	}
	
	func isReachableFileTypeOf(_ pathExtension: String) -> Bool
	{
		return (self.isReachableFile && self.isFileTypeOf(pathExtension))
	}
	
	var fileName: String {
		if self.hasDirectoryPath {
			return self.lastPathComponent.removingPercentEncodingSafe
		}
		return self.deletingPathExtension().lastPathComponent.removingPercentEncodingSafe
	}
	
	@available(*, deprecated, renamed: "fileNameFull")
	var fileNameWithExtension: String {
		return self.fileNameFull
	}
	
	var fileNameFull: String {
		if self.hasDirectoryPath {
			return self.lastPathComponent.removingPercentEncodingSafe
		}
		return self.lastPathComponent.removingPercentEncodingSafe
	}
	
	var isFile: Bool {
		return !self.isDirectory
	}
	
	var isDirectory: Bool {
		return self.hasDirectoryPath
	}
	
	var isReachable: Bool {
		//		guard let _ = try? self.checkResourceIsReachable() else { return false }
		//		return true
		guard let filePath = self.absoluteURL.path.removingPercentEncoding else { return false }
		return FileManager.default.fileExists(atPath: filePath)
	}
	
	var isReachableFile: Bool {
		return self.isFile && self.isReachable
	}
	
	var isReachableDirectory: Bool {
		return self.isDirectory && self.isReachable
	}
    
    var isImageURL: Bool {
        return self.mime.contentType.lowercased().starts(with: "image")
    }
    
    var isVideoURL: Bool {
        guard let uti = self.uti else {
            return AVURLAsset.audiovisualMIMETypes().contains(self.mime.contentType)
        }
        
        return AVURLAsset.audiovisualTypes().contains(AVFileType(uti))
    }
    
    var isPDFURL: Bool {
        return self.mime.contentType.lowercased().contains("pdf")
    }
}




