//
//  DateFormatter.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-09.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension DateFormatter
{
	static var properISO8601: DateFormatter {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
		formatter.calendar = Calendar(identifier: Calendar.Identifier.iso8601)
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		return formatter
	}
}




