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
    static func log(file: String = #file,
                    function: String = #function,
                    line: Int = #line,
                    _ items: Any...)
    {
        let items = [file.fileNameFull, function, line] + items
        print(items.joined(by: " "))
    }
    
    /// Log the sender type and items
    static func log<T>(function: String = #function,
                       sender: T,
                       _ items: Any...)
    {
        let items = [type(of: sender), function] + items
        print(items.joined(by: " "))
    }
    
    
    
    /// block cast
    @discardableResult
    static func cast<T>(_ object: Any?,
                        _ type: T.Type,
                        _ block: ((T) -> Void)) -> T?
    {
        let t = object as? T
        
        if t != nil {
            block(t!)
        }
        
        return t
    }
}





