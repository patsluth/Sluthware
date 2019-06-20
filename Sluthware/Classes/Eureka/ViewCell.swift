//
//  ViewCell.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import Eureka





open class _ViewCell<View>: Cell<NSNull>
	where View: UIView
{
	
}





open class ViewCell<View>: _ViewCell<View>, CellType
	where View: UIView
{
	public fileprivate(set) var view: View!
	
	
	
	
	
	open override func setup()
	{
		super.setup()
		
		self.backgroundColor = nil
		self.textLabel?.isHidden = true
		self.detailTextLabel?.isHidden = true
		self.selectionStyle = .none
		
		self.view = View.make({
			self.contentView.addSubview($0)
		}).make(constraints: {
			$0.edges.equalTo(self.contentView.snp.margins)
		})
		
		self.contentView.setNeedsLayout()
		
		self.height = { UITableView.automaticDimension }
	}
	
	open override func update()
	{
		super.update()
	}
	
	//	open override func cellCanBecomeFirstResponder() -> Bool
	//	{
	//		return self.viewRow.view.canBecomeFirstResponder
	//	}
	
	//	open override func cellResignFirstResponder() -> Bool
	//	{
	//		return self.viewRow.view.resignFirstResponder()
	//	}
	//
	//	open override func cellBecomeFirstResponder(withDirection: Direction = .down) -> Bool
	//	{
	//		return self.viewRow.view.becomeFirstResponder()
	//	}
	//
	//	open override var inputAccessoryView: UIView?
	//	{
	//		if self.viewRow.view.isFirstResponder {
	//			return self.viewRow.view.inputAccessoryView
	//		}
	//		return super.inputAccessoryView
	//	}
}





open class _ViewRow<View>: Row<ViewCell<View>>
	where View: UIView
{
	public required init(tag: String?)
	{
		super.init(tag: tag)
		
		self.cellProvider = CellProvider<ViewCell<View>>()
	}
}





public protocol ViewRowType: BaseRow, RowType
{
}





public extension ViewRowType
{
	init(_ cellSetup: @escaping ((Self.Cell, Self) -> Void))
	{
		self.init(nil, {
			$0.cellSetup({ cell, row in
				cellSetup(cell, row)
			})
		})
	}
}





/// A row that displays a custom view and value associated with that view
public final class ViewRow<View>: _ViewRow<View>, ViewRowType
	where View: UIView
{
}




