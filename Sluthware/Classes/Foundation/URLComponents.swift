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
	var queryItemsByName: [String: URLQueryItem]? {
		return self.queryItems?.reduce(into: [String: URLQueryItem]()) {
			$0[$1.name] = $1
		}
	}
}




