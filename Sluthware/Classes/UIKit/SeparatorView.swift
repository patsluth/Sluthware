//
//  SeparatorView.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import UIKit





/// Uses layout margins by default. To use full width or height set preservesSuperviewLayoutMargins to false
public class SeparatorView: UIView
{
	public typealias Axis = NSLayoutConstraint.Axis
	
	
	
	public var axis: Axis = .horizontal {
		didSet { self.setNeedsUpdateConstraints() }
	}
	
	/// Either the height or the width depending on the axis
	public var value: CGFloat = 0.0 {
		didSet { self.setNeedsUpdateConstraints() }
	}
	
	override public var preservesSuperviewLayoutMargins: Bool {
		didSet { self.setNeedsUpdateConstraints() }
	}
	
	public private(set) var lineView: UIView!
	
	
	
	
	
	override init(frame: CGRect)
	{
		super.init(frame: frame)
		
		self.preservesSuperviewLayoutMargins = false
		self.isUserInteractionEnabled = false
		
		self.lineView = UIView.make({
			$0.backgroundColor = .lightGray
			
			self.addSubview($0)
		})
		
		defer {
			self.value = 1
		}
	}
	
	required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
	}
	
	public override func invalidateIntrinsicContentSize()
	{
		super.invalidateIntrinsicContentSize()
		
		self.setNeedsUpdateConstraints()
	}
	
	public override func updateConstraints()
	{
		defer { super.updateConstraints() }
		
		let preservesMargins = self.preservesSuperviewLayoutMargins
		
		self.lineView.remake(constraints: {
			switch self.axis {
			case .horizontal:
				$0.leading.equalTo((preservesMargins) ? self.snp.leadingMargin : self.snp.leading)
				$0.top.equalTo(self.snp.top)
				$0.trailing.equalTo((preservesMargins) ? self.snp.trailingMargin : self.snp.trailing)
				$0.bottom.equalTo(self.snp.bottom)
				$0.height.equalTo(self.value)
			case .vertical:
				$0.leading.equalTo(self.snp.leading)
				$0.top.equalTo((preservesMargins) ? self.snp.topMargin : self.snp.top)
				$0.trailing.equalTo(self.snp.trailing)
				$0.bottom.equalTo((preservesMargins) ? self.snp.bottomMargin : self.snp.bottom)
				$0.width.equalTo(self.value)
			@unknown default:
				$0.edges.equalTo((preservesMargins) ? self.snp.margins : self)
			}
		})
	}
}




