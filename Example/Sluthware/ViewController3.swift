//
//  ViewController3.swift
//  Sluthware
//
//  Created by patsluth on 12/19/2017.
//  Copyright (c) 2017 patsluth. All rights reserved.
//

import UIKit





class ViewController3: UIViewController, UITableViewDataSource, UITableViewDelegate
{
	@IBOutlet fileprivate var heightConstraintTop: NSLayoutConstraint!
	@IBOutlet fileprivate var tableView: UITableView!
	@IBOutlet fileprivate var heightConstraintBottom: NSLayoutConstraint!
	
	lazy var dataSource: [String] = {
		var colors = [String]()
		for char in "abcdefghijklmnopasdfasdfasdfafafqrstuyzzz".characters {
			colors.append(String(char))
		}
		return colors
	}()
	
	
	
    override func viewDidLoad()
    {
		super.viewDidLoad()
    }
	
	
	
	
	
	
	
	// MARK: UITableViewDataSource
	
	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(_ tableView: UITableView,
				   numberOfRowsInSection section: Int) -> Int
	{
		return self.dataSource.count
	}
	
	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
		
		if cell == nil {
			cell = UITableViewCell(style: UITableViewCell.CellStyle.default,
								   reuseIdentifier: "Cell")
		}
		
		return cell!
	}
	
	
	
	
	
	// MARK: UITableViewDelegate
	
	func tableView(_ tableView: UITableView,
				   willDisplay cell: UITableViewCell,
				   forRowAt indexPath: IndexPath)
	{
		cell.textLabel?.text = self.dataSource[indexPath.row]
	}
	
	func tableView(_ tableView: UITableView,
				   didEndDisplaying cell: UITableViewCell,
				   forRowAt indexPath: IndexPath)
	{
		cell.prepareForReuse()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	{
		if indexPath.row == 0 {
			if self.heightConstraintTop.constant <= 0.0 {
				self.heightConstraintTop.constant = 50.0
			} else {
				self.heightConstraintTop.constant = 0.0
			}
		} else if indexPath.row >= self.dataSource.count - 1 {
			if self.heightConstraintBottom.constant <= 0.0 {
				self.heightConstraintBottom.constant = 50.0
			} else {
				self.heightConstraintBottom.constant = 0.0
			}
		}
		
		self.view.setNeedsLayout()
	}
}





