//
//  URLComponents.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public extension URLComponents
{
	var queryItemsByName: [String: String]? {
		return self.queryItems?.reduce(into: [String: String]()) { result, element in
			if let value = element.value {
				result[element.name] = value
			}
		}
	}
}




