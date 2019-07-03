//
//  Eureka+RxSwift.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import UIKit

import RxSwift
import RxCocoa
import Eureka





extension RowOf: ReactiveCompatible
{
    
}





public extension Reactive
	where Base: RowType, Base: BaseRow
{
	var value: ControlProperty<Base.Cell.Value?> {
		let source = Observable<Base.Cell.Value?>.create({ observer in
            self.base.onChange({ row in
                observer.onNext(row.value)
            })
            
            return Disposables.create()
        }).startWith(self.base.value)
		
		let target = Binder(self.base, binding: { row, value in
			row.value = value
		})
		
		return ControlProperty(values: source, valueSink: target)
	}
}




