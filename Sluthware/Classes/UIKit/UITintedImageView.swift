//
//  UITintedImageView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//





public class UITintedImageView: UIImageView
{
    override public var image: UIImage? {
        didSet
        {
            guard let image = self.image else { return }
            guard image.renderingMode != .alwaysTemplate else { return }
            
            self.image = image.withRenderingMode(.alwaysTemplate)
        }
    }
}




