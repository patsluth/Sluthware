//
//  ObservableType+log.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa





public extension ObservableType
{
	public func logOnDispose(file: String = #file,
							 function: String = #function,
							 line: Int = #line) -> Observable<E>
	{
		return self.do(onDispose: {
			print(file.fileNameFull, function, line, "onDispose")
		})
	}
	
	public func logOnCompleted(file: String = #file,
							   function: String = #function,
							   line: Int = #line) -> Observable<E>
	{
		return self.do(onCompleted: {
			print(file.fileNameFull, function, line, "onCompleted")
		})
	}
}




