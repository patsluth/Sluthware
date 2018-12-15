//
//  UIScrollView+Paging.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





public extension UIScrollView
{
	public typealias Page = (x: Int, y: Int)
	
	
	
	
	
	func currentPage() -> UIScrollView.Page?
	{
		guard self.isPagingEnabled else { return nil }
		
		return Page(x: Int(round(self.contentOffset.x / self.bounds.width)),
					y: Int(round(self.contentOffset.y / self.bounds.height)))
	}
	
	func lastPage() -> UIScrollView.Page?
	{
		guard self.isPagingEnabled else { return nil }
		guard self.bounds.width > 0.0 else { return nil }
		guard self.bounds.height > 0.0 else { return nil }
		
		return Page(x: Int(round(self.contentSize.width / self.bounds.width)),
					y: Int(round(self.contentSize.height / self.bounds.height)))
	}
	
	func centrePage() -> UIScrollView.Page?
	{
		guard let lastPage = self.lastPage() else { return nil }
		
		return Page(x: Int(CGFloat(lastPage.x) / 2.0),
					y: Int(CGFloat(lastPage.y) / 2.0))
	}
	
	func contentOffset(for page: UIScrollView.Page) -> CGPoint
	{
		return CGPoint(x: self.bounds.width * CGFloat(page.x),
					   y: self.bounds.height * CGFloat(page.y))
	}
}





