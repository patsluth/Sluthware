//
//  StoryboardResourceWithInitialControllerType.swift
//  Sluthware
//
//  Created by Pat Sluth on 2019-02-25.
//

import UIKit

import Rswift





public extension StoryboardResourceWithInitialControllerType
{
	func instantiate(_ initialViewController: (InitialController) -> Void)
	{
		guard let viewController = self.instantiateInitialViewController() else { return }
		
		initialViewController(viewController)
	}
}




