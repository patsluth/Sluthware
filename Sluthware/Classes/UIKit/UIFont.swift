//
//  UIFont.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





#if os(iOS)

public extension UIFont
{
	func scaledBy<T>(percent: T) -> UIFont
		where T: Sluthware.FloatingPointType
	{
		return self.withSize(self.pointSize * CGFloat(percent))
	}
}

#endif




