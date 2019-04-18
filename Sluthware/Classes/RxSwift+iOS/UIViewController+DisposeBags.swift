//
//  UIViewController+DisposeBags.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa





public extension UIViewController
{
	/// A container for dispose bags. You must manually
	/// set the values other than deinit to dispose
	struct DisposeBags
	{
		public let `deinit`: DisposeBag
		public var willDisappear: DisposeBag
		public var didDisappear: DisposeBag
		
		public init()
		{
			self.deinit = DisposeBag()
			self.willDisappear = DisposeBag()
			self.didDisappear = DisposeBag()
		}
	}
}




