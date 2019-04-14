//
//  Sluthware.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//





public func printSW(file: String = #file,
					function: String = #function,
					line: Int = #line,
					_ items: Any...)
{
	var items = [file.fileNameFull, function, line] + items
	print(items.joined(separator: " "))
}





public func printSW<T>(function: String = #function,
					   sender: T,
					   _ items: Any...)
{
	var items = [T.self, function] + items
	print(items.joined(separator: " "))
}




