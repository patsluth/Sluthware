//
//  TimeComponent.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public enum TimeComponent: String, CaseIterable
{
	case nanosecond
	case second
	case minute
	case hour
	case day
	case week
	case month
	case quarter
	case year
}





public extension TimeComponent
{
	public var timeInterval: TimeInterval {
		switch self {
		case .nanosecond:		return 1e-9
		case .second: 			return 1
		case .minute: 			return 60
		case .hour: 			return 3600
		case .day: 				return 86400
		case .week: 			return 604800
		case .month: 			return 2592000
		case .quarter: 			return 7884000
		case .year: 			return 30758400
		}
	}
	
	public var calendarComponent: Calendar.Component {
		switch self {
		case .nanosecond:		return .nanosecond
		case .second: 			return .second
		case .minute: 			return .minute
		case .hour: 			return .hour
		case .day: 				return .day
		case .week: 			return .weekOfMonth
		case .month: 			return .month
		case .quarter: 			return .quarter
		case .year: 			return .year
		}
	}
}





