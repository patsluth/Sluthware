//
//  Result+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





#if swift(>=5.0)

public extension Swift.Result
{
	init?(_ success: Success?, _ failure: Failure?)
	{
		if let success = success {
			self = .success(success)
		} else if let failure = failure {
			self = .failure(failure)
		}
		
		return nil
	}
}

#endif




