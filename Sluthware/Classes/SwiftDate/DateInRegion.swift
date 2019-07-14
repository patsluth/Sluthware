//
//  DateInRegion.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-04-04.
//

import Foundation

import SwiftDate





public extension DateInRegion
{
	/// String representation of date in provided region, defaults to current device region.
	func toString(_ format: String, _ region: Region = Region.local) -> String
	{
		if self.region == region {
			return self.toFormat(format, locale: region.locale)
		} else {
			return self.convertTo(region: region).toFormat(format)
		}
	}
}




