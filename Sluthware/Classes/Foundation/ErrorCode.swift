//
//  ErrorCode.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public struct ErrorCode<CodeType>: ReflectedStringConvertible
	where CodeType: RawRepresentable, CodeType.RawValue == Int
{
	let code: CodeType?
	let error: Error
	
	public init(_ error: Error)
	{
		self.code = CodeType(rawValue: error._code)
		self.error = error
	}
}




