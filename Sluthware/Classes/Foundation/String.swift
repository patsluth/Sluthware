//
//  String.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//

import Foundation





public extension String
{
	var fileName: String {
		var fileName = (self as NSString)
		fileName = (fileName.deletingPathExtension as NSString)
		fileName = (fileName.lastPathComponent as NSString)
		return fileName.removingPercentEncoding ?? (fileName as String)
	}
	
	var fileNameWithExtension: String {
		var fileName = (self as NSString)
		fileName = (fileName.lastPathComponent as NSString)
		return fileName.removingPercentEncoding ?? (fileName as String)
	}
	
	var camelCaseToWords: [String] {
		return self.unicodeScalars.reduce([String]()) {
			var result = $0
			if CharacterSet.uppercaseLetters.contains($1) == true {
				result.append("\($1)")
			} else {
				let last = result.popLast() ?? ""
				result.append("\(last)\($1)")
			}
			return result
		}
	}
	
	var removingPercentEncodingSafe: String {
		return self.removingPercentEncoding ?? self
	}
	
	
	
	
	
	func removing(charactersNotIn characterSet: CharacterSet) -> String
	{
		return String(self.unicodeScalars.filter { characterSet.contains($0) })
	}
}





