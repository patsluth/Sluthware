//
//  UIViewController+UIDocumentInteraction.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-12-03.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation





fileprivate var _documentInteractionController = Selector(("_documentInteractionController"))

@available(iOS 10.0, *)
public extension UIDocumentInteractionControllerDelegate where Self: UIViewController
{
	var documentInteractionController: UIDocumentInteractionController?
	{
		get
		{
			return objc_getAssociatedObject(self, &_documentInteractionController) as? UIDocumentInteractionController
		}
		set
		{
			objc_setAssociatedObject(self,
									 &_documentInteractionController,
									 newValue,
									 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
		}
	}
}




