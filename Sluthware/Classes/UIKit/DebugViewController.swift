//
//  DebugViewController.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-01-05.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation
import UIKit





public final class DebugViewController: UIViewController
{
	@IBOutlet public private(set) var textView: UITextView!
	
	
	
	
	
	public override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.navigationItem.rightBarButtonItem = {
			return UIBarButtonItem(barButtonSystemItem: .done,
								   target: self,
								   action: #selector(self.doneButtonClicked(_:)))
		}()
	}
	
	@objc private func doneButtonClicked(_ sender: Any)
	{
		self.dismiss(animated: true, completion: nil)
	}
//	public static func showVC(on: UIViewController, _ stringBuilder: StringBuilder)
//	{
//		let view: UIView = {
//			let view = UIView()
//
//			view.backgroundColor = UIColor.white
//
//			return view
//		}()
//
//		let textView: UITextView = {
//			let textView = UITextView()
//
//			textView.translatesAutoresizingMaskIntoConstraints = false
//			textView.textAlignment = NSTextAlignment.left
//			//			textView.mode = UIView.ContentMode.
//			//			textView.attributedText = stringBuilder.attributed
//
//			return textView
//		}()
//		let font = UIFont.systemFont(ofSize: 29.0)
//		view.addSubview(textView)
//
//
//
//
//		NSLayoutConstraint.activate([
//			textView.topAnchor.constraint(equalTo: view.safeTopAnchor),
//			textView.leftAnchor.constraint(equalTo: view.safeLeftAnchor),
//			textView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor),
//			textView.rightAnchor.constraint(equalTo: view.safeRightAnchor),
//			])
//
//		let viewController = UIViewController()
//		viewController.view = view
//		let navigationController = UINavigationController(rootViewController: viewController)
//
//		on.present(navigationController, animated: true, completion: nil)
//	}
}




