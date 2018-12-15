//
//  Errors.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





public enum Errors: Error
{
	case Init
	case Message(String)
	case Decoding(Any.Type, [CodingKey])
}





//extension Errors: CustomStringConvertible
//{
//	public var description: String {
//		var description = String(describing: Errors.self) + "."
//		switch self {
//		case Errors.Init:
//			description += "Init"
//			break
//		case Errors.Message(let message):
//			description += "Message(" + message + ")"
//			break
//		}
//		return description
//	}
//}
//
//
//
//
//
//extension Errors: CustomDebugStringConvertible
//{
//	public var debugDescription: String {
//		return self.description
//	}
//}




