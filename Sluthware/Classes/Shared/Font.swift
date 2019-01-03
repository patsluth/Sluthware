//
//  Font.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

#if os(iOS) || os(watchOS) || os(tvOS)
public typealias Font = UIFont
#elseif os(macOS)
public typealias Font = NSFont
#endif





public extension Font
{
	func scaledBy<T>(percent: T) -> UIFont
		where T: Sluthware.FloatingPointType
	{
		return self.withSize(self.pointSize * CGFloat(percent))
	}
	
	public func forFraction() -> UIFont
	{
		let fontDescriptor = self.fontDescriptor.addingAttributes([
			UIFontDescriptor.AttributeName.featureSettings: [[
				UIFontDescriptor.FeatureKey.featureIdentifier: kFractionsType,
				UIFontDescriptor.FeatureKey.typeIdentifier: kDiagonalFractionsSelector,
				],
			]])
		
		return UIFont(descriptor: fontDescriptor, size: self.pointSize)
	}
}




