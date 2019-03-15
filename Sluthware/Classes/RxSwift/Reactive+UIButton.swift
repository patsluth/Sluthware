//
//  Reactive+UIButton.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa





public extension Reactive
	where Base: UIButton
{
	public func onTap(throttle: RxTimeInterval = 0.25,
					  _ block: @escaping () -> Void) -> Disposable
	{
		return self.tap
			.asDriver()
			.throttle(throttle)
			.drive(onNext: {
				block()
			})
	}
}




