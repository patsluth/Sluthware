//
//  Sluthware.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//





@available(*, deprecated, renamed: "swlog(_items:)")
public func printSW(file: String = #file,
					function: String = #function,
					line: Int = #line,
					_ items: Any...)
{
	swlog(file: file, function: function, line: line, items)
}

/// Logs prefix print(items) with file, function and line
public func swlog(file: String = #file,
				  function: String = #function,
				  line: Int = #line,
				  _ items: Any...)
{
	var items = [file.fileNameFull, function, line] + items
	print(items.joined(separator: " "))
}



@available(*, deprecated, renamed: "swlog(sender:_items:)")
public func printSW<T>(function: String = #function,
					   sender: T,
					   _ items: Any...)
{
	swlog(function: function, sender: sender, items)
}

/// Log the sender type and items
public func swlog<T>(function: String = #function,
					 sender: T,
					 _ items: Any...)
{
	var items = [type(of: sender), function] + items
	print(items.joined(separator: " "))
}





@discardableResult
public func cast<T>(_ object: Any!, as type: T.Type, _ block: (T) -> Void) -> Bool
{
	if let t = object as? T {
		block(t)
		return true
	}
	return false
}




