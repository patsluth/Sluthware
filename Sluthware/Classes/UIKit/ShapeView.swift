//
//  ShapeView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit





//@IBDesignable
public class ShapeView: UIView
{
	private lazy var maskLayer: CAShapeLayer = {
		let maskLayer = CAShapeLayer()
		self.layer.mask = maskLayer
		return maskLayer
	}()
	
	@IBInspectable
	public var rawShape: String? {
		get { return self.shape?.rawValue }
		set { self.shape = Shape(rawValue: self.rawShape ?? "") }
	}
	
	public var shape: Shape? = nil {
		didSet
		{
			self.clipsToBounds = true
			self.layer.masksToBounds = true
			
			self.maskLayer.path = self.shape?.bezierPath(for: self).cgPath
		}
	}
	
	
	
	
	
	public override func didMoveToSuperview()
	{
		super.didMoveToSuperview()
	}
	
	public override func layoutSubviews()
	{
		super.layoutSubviews()
		
		self.shape = { self.shape }()
	}
}





public enum Shape: String
{
	case Circle
	case Triangle
	
	func bezierPath(for view: UIView) -> UIBezierPath
	{
		var path = UIBezierPath()
		
		switch self {
		case .Circle:
			path = UIBezierPath(ovalIn: view.bounds)
		case .Triangle:
			// UP
			path.move(to: CGPoint(x: view.bounds.minX, y: view.bounds.maxY))
			//		trianglePath.addLine(to: CGPoint(x: -size, y: up ? size : -size))
			//		trianglePath.addLine(to: CGPoint(x: size, y: up ? size : -size))
			path.addLine(to: CGPoint(x: view.bounds.midX, y: view.bounds.minY))
			path.addLine(to: CGPoint(x: view.bounds.maxX, y: view.bounds.maxY))
			path.close()
			
			// Rotationn
			//			path.apply(CGAffineTransform(rotationAngle: 75.0))
		}
		
		return path
	}
}




