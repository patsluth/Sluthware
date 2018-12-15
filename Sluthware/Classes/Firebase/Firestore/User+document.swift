//
//  User+document.swift
//  Sluthware
//
//  Created by Pat Sluth on 2018-10-17.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

import FirebaseAuth
import FirebaseFirestore





public extension User
{
	public var document: DocumentReference {
		return Firestore.firestore()
			.collection("users")
			.document(self.uid)
	}
}




