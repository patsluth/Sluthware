//
//  MediaURL.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation

public enum MediaURLError: Error
{
    case InvalidURL
}

public enum MediaURL {
    case image(URL)
    case video(URL)
    case pdf(URL)
    
    var url: URL {
        switch self {
        case .image(let url):
            return url
        case .video(let url):
            return url
        case .pdf(let url):
            return url
        }
    }
    
    init(url: URL) throws {
        switch url {
        case let url where url.isImageURL:
            self = .image(url)
        case let url where url.isVideoURL:
            self = .video(url)
        case let url where url.isPDFURL:
            self = .pdf(url)
        default:
            throw MediaURLError.InvalidURL
        }
    }
}
