//
//  ViewController2.swift
//  Sluthware
//
//  Created by patsluth on 12/19/2017.
//  Copyright (c) 2017 patsluth. All rights reserved.
//

import UIKit



//extension UIView
//{
//	func addSubview(_ block: () -> UIView)
//	{
//		let view = 
//	}
//}











//extension UIView {
//	var ancestors: AnySequence<UIView> {
//		return sequence(first: self, next: { $0.superview }).dropFirst(0)
//	}
//}



class ViewController2: UIViewController
{
	@IBOutlet fileprivate var collectionView: UICollectionView!
	@IBOutlet fileprivate var pageControl: UIPageControl!
	
	
	
	
	
    override func viewDidLoad()
    {
		super.viewDidLoad()
		let types: [AnyTypeContainer] = [TypeContainer(UISearchBar.self), TypeContainer(UICollectionView.self)]
		for t in types {
			print("A", t.containsMember(self.collectionView), t.containsKind(self.collectionView))
			print("A", t.containsMember(type(of: self.collectionView)), t.containsKind(type(of: self.collectionView)))
//			print("B", t.contains(self.collectionView))
//			print("C", t.contains(type(of: self.collectionView)))
//			print(t.containsType(of: type(of: self.collectionView!)))
		}
//		print(types.contains(where: {
//			let cclass = self.collectionView.classForCoder.isKind($0)
//			return $0.isKind(self.collectionView.classForCoder)
//		}))
		
		
		let nib = UINib(nibName: "WatchlistCell", bundle: nil)
		self.collectionView.register(nib,
									 forCellWithReuseIdentifier: "WatchlistCell")
    }
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
		
//		self.collectionView.reloadData()
		
		
		self.collectionView.reloadData()
		self.pageControl.numberOfPages = self.collectionView.lastPage()?.x ?? 0
		
		let color = UIColor.green.lighter(by: 0.5)
		self.collectionView.backgroundColor = UIColor.gradient(size: UIScreen.main.bounds.size,
															   startPoint: CGPoint(x: 0.0, y: 0.5),
															   endPoint: CGPoint(x: 1.0, y: 0.5),
															   colors: color, color.darker(by: 0.5))
		
		
		
		
		
		let vc = DebugViewController(nibName: "DebugViewController",
									 bundle: Bundle(for: DebugViewController.classForCoder()))
		let nc = UINavigationController(rootViewController: vc)
		self.present(nc, animated: true) {
			let fracations: [Fraction] = [20 / 11,
										  5 / 7,
										  Fraction(0.25),
										  4 / 0,
										  0 / 4,
										  Fraction.NaN]
			
			let attributedFormatter = FractionAttributedFormatter() {
				$0.font = UIFont.systemFont(ofSize: 25.0)
				$0.useProperFractions = true
			}
			
			vc.textView.attributedText = fracations.reduce(into: NSAttributedString(), {
				$0 += attributedFormatter.format($1.roundedTo(den: 15))
				$0 += Char.NewLine
			})
		}
	}
	
	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()
		
		self.collectionView.collectionViewLayout.invalidateLayout()
	}
	
	lazy var cellColors: [String] = {
		var colors = [String]()
		for char in "abcdefghijklmnopasdfasdfasdfafafqrstuyzzz".characters {
			colors.append(String(char))
		}
		return colors
	}()
}





extension ViewController2: UICollectionViewDataSource
{
	func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return 0
//		return Int(ceil(Double(self.cellColors.count) / 9.0)) * 3
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return self.cellColors.count
//		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WatchlistCell", for: indexPath) as! WatchlistCell
		
		return cell
	}
}





extension ViewController2: UICollectionViewDelegateFlowLayout
{
	func collectionView(_ collectionView: UICollectionView,
						willDisplay cell: UICollectionViewCell,
						forItemAt indexPath: IndexPath)
	{
		let cell = cell as! WatchlistCell
		
		cell.titleLabel.text = self.cellColors[safe: indexPath.item]
		cell.detailLabel.text = String(indexPath.item)
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		self.screenshot()
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: collectionView.bounds.width / 2.0,
					  height: collectionView.bounds.height / 5.0)
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0.0
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
	{
		return 0.0
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView)
	{
		self.pageControl.currentPage = scrollView.currentPage()?.x ?? 0
	}
	
	func screenshot()
	{
		let pdfData = self.collectionView.generatePDFDataFor(title: "PAT PAT",
											   titleFont: UIFont.systemFont(ofSize: 21.0),
											   headerViews: [],
											   footerViews: [])
		
		
		
		var fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test.pdf")
		pdfData?.write(to: fileURL, atomically: true)
		
		print(fileURL)
//		let documentInteractionController = UIDocumentInteractionController(url: fileURL!)
//		documentInteractionController.delegate = self
//		documentInteractionController.presentOptionsMenu(from: self.imageView.frame,
//														 in: self.view,
//														 animated: true)
	}
}





