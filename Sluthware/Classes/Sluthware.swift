//
//  Sluthware.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//





/// Sluthware global functions
public enum sw
{
    /// Logs prefix print(items) with file, function and line
    public static func log(file: String = #file,
                           function: String = #function,
                           line: Int = #line,
                           _ items: Any...)
    {
        var items = [file.fileNameFull, function, line] + items
        print(items.joined(separator: " "))
    }
    
    /// Log the sender type and items
    public static func log<T>(function: String = #function,
                              sender: T,
                              _ items: Any...)
    {
        var items = [type(of: sender), function] + items
        print(items.joined(separator: " "))
    }
    
    
    
    /// block cast
    @discardableResult
    public static func cast<T>(_ object: Any, _ type: T.Type, _ block: ((T) -> Void)? = nil) -> T?
    {
        let t = object as? T
        
        if t != nil {
            block?(t!)
        }
        
        return t
    }
}





