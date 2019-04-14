//
//  Alamofire+SW.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-26.
//

import Foundation

import Alamofire





public extension Alamofire.Result
	where Value: Decodable
{
	init(_ value: Any)
	{
		do {
			self = .success(try Value.decode(value))
		} catch {
			self = .failure(error)
		}
	}
}




