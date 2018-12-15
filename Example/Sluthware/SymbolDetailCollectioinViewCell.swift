//
//  WatchlistCell.swift
//  SWQuestrade
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation





final class WatchlistCell: UICollectionViewCell
{
	@IBOutlet fileprivate(set) var titleLabel: UILabel!
	@IBOutlet fileprivate(set) var detailLabel: UILabel!
	
	
	
	
	
	override func prepareForReuse()
	{
		super.prepareForReuse()
		
		self.titleLabel.text = nil
		self.detailLabel.text = nil
	}
}




