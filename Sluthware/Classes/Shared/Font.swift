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
public typealias FontDescriptor = UIFontDescriptor
#elseif os(macOS)
public typealias Font = NSFont
public typealias FontDescriptor = NSFontDescriptor
#endif





public extension Font
{
    func scaledBy<T>(percent: T) -> Font!
        where T: Sluthware.FloatingPointType
    {
        return self.withSize(self.pointSize * CGFloat(percent))
    }
    
    func forFraction() -> Font!
    {
        #if os(iOS) || os(watchOS) || os(tvOS)
        let attributes = [
            FontDescriptor.AttributeName.featureSettings: [[
                FontDescriptor.FeatureKey.featureIdentifier: kFractionsType,
                FontDescriptor.FeatureKey.typeIdentifier: kDiagonalFractionsSelector,
                ],
            ]]
        #elseif os(macOS)
        let attributes = [
            FontDescriptor.AttributeName.featureSettings: [[
                FontDescriptor.FeatureKey.typeIdentifier: kFractionsType,
                FontDescriptor.FeatureKey.selectorIdentifier: kDiagonalFractionsSelector,
                ],
            ]]
        #endif
        
        return Font(descriptor: self.fontDescriptor.addingAttributes(attributes),
                    size: self.pointSize)
    }
    
    func withSize(_ fontSize: CGFloat) -> Font!
    {
        return Font(descriptor: self.fontDescriptor, size: fontSize)
    }
    
    func with(traits: FontDescriptor.SymbolicTraits) -> Font?
    {
        #if os(macOS)
        let fontDescriptor = self.fontDescriptor.withSymbolicTraits(traits)
        return Font(descriptor: fontDescriptor, size: self.pointSize)
        #else
        if let fontDescriptor = self.fontDescriptor.withSymbolicTraits(traits) {
            return Font(descriptor: fontDescriptor, size: self.pointSize)
        }
        return nil
        #endif
    }
}





//#if os(macOS)

//extension Font
//{
//
//}

//#elseif os(macOS)
//
//extension NSFont
//{
//    func withSize(_ fontSize: CGFloat) -> Font!
//    {
//        return Font(descriptor: self.fontDescriptor, size: fontSize)
//    }
//}
//
//#endif




