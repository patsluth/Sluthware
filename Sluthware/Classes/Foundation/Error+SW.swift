//
//  Error.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation





public extension Error
{
    var ns: NSError {
        return self as NSError
    }
    
    
    
    
    
    @discardableResult
    func log(file: String = #file,
             function: String = #function,
             line: Int = #line) -> Self
    {
        sw.log(file: file.fileNameFull,
               function: function,
               line: line,
               type(of: self),
               self.localizedDescription)
        
        return self
    }
}




