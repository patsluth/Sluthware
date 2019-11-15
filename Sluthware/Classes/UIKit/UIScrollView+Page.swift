//
//  UIScrollView+Page.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension UIScrollView
{
	struct Page
	{
		public let x: Int
		public let y: Int
		
		static var zero: Page {
			return Page(x: 0, y: 0)
		}
	}
	
	
	
	
	
	var currentPage: UIScrollView.Page {
		//		guard self.isPagingEnabled else { return Page.zero }
		guard self.bounds.width > 0.0 else { return Page.zero }
		guard self.bounds.height > 0.0 else { return Page.zero }
		
		return Page(x: Int(round(self.contentOffset.x / self.bounds.width)),
					y: Int(round(self.contentOffset.y / self.bounds.height)))
	}
	
	var lastPage: UIScrollView.Page {
		//		guard self.isPagingEnabled else { return Page.zero }
		guard self.bounds.width > 0.0 else { return Page.zero }
		guard self.bounds.height > 0.0 else { return Page.zero }
		
		return Page(x: Int(round(self.contentSize.width / self.bounds.width)),
					y: Int(round(self.contentSize.height / self.bounds.height)))
	}
	
	var centrePage: UIScrollView.Page {
		let lastPage = self.lastPage
		
		return Page(x: Int(CGFloat(lastPage.x) * 0.5),
					y: Int(CGFloat(lastPage.y) * 0.5))
	}
	
	func contentOffset(for page: UIScrollView.Page) -> CGPoint
	{
		return CGPoint(x: self.bounds.width * CGFloat(page.x),
					   y: self.bounds.height * CGFloat(page.y))
	}
}





