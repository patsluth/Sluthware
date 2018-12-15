//
//  Gradient.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-11-02.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension UIImage
{
	public static func gradient(size: CGSize,
						 startPoint: CGPoint,
						 endPoint: CGPoint,
						 colors: UIColor...) -> UIImage?
	{
		return self.gradient(size: size,
							 startPoint: startPoint,
							 endPoint: endPoint,
							 colors: colors)
	}
	
	public static func gradient(size: CGSize,
						 startPoint: CGPoint,
						 endPoint: CGPoint,
						 colors: [UIColor]) -> UIImage?
	{
		let gradientLayer: CAGradientLayer = {
			let layer = CAGradientLayer()
			layer.frame = CGRect(origin: CGPoint.zero, size: size)
			layer.colors = colors.map({ $0.cgColor })
			layer.startPoint = startPoint
			layer.endPoint = endPoint
			return layer
		}()
		
		UIGraphicsBeginImageContext(gradientLayer.bounds.size)
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		defer { UIGraphicsEndImageContext() }
		
		gradientLayer.render(in: context)
		
		return UIGraphicsGetImageFromCurrentImageContext()
	}
}





public extension UIColor
{
	public static func gradient(size: CGSize,
						 startPoint: CGPoint,
						 endPoint: CGPoint,
						 colors: UIColor...) -> UIColor?
	{
		return self.gradient(size: size,
							 startPoint: startPoint,
							 endPoint: endPoint,
							 colors: colors)
	}
	
	public static func gradient(size: CGSize,
						 startPoint: CGPoint,
						 endPoint: CGPoint,
						 colors: [UIColor]) -> UIColor?
	{
		guard let image = UIImage.gradient(size: size,
										   startPoint: startPoint,
										   endPoint: endPoint,
										   colors: colors) else { return nil }
		
		return UIColor(patternImage: image)
	}
}




