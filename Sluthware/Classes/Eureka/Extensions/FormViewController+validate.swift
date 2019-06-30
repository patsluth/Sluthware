//
//  FormViewController+validate.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import UIKit

import Eureka





public extension FormViewController
{
	@discardableResult
	func validate(includeHidden: Bool = false,
				  includeDisabled: Bool = true,
				  scrollToFirstInvalidRow: Bool = true) -> [Eureka.ValidationError]
	{
		var rows = (includeHidden) ? self.form.allRows : self.form.rows
		rows = rows.filter({
			(includeDisabled) ? true : $0.isDisabled != true
		})
		
		var firstInvalidIndexPath: IndexPath? = nil
		let errors = rows.reduce(into: [Eureka.ValidationError]()) {
			let errors = $1.validate()
			if !errors.isEmpty && firstInvalidIndexPath == nil {
				firstInvalidIndexPath = $1.indexPath
			}
			$0 += errors
		}
		
		if let indexPath = firstInvalidIndexPath {
			self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
		}
		
		return errors
	}
}




