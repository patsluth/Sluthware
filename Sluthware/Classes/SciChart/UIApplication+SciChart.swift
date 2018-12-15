//
//  UIApplication+SciChart.swift
//  Sluthware
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import SciChart





public extension UIApplication
{
	public func initializeSciChart()
	{
		let proLicenceKey = """
		    <LicenseContract>
		    <Customer>Sluthware</Customer>
		    <OrderId>ABT171012-4035-24140</OrderId>
		    <LicenseCount>1</LicenseCount>
		    <IsTrialLicense>false</IsTrialLicense>
		    <SupportExpires>10/12/2018 00:00:00</SupportExpires>
		    <ProductCode>SC-IOS-2D-PRO</ProductCode>
		    <KeyCode>70b3884b43f4de19d595d2eb9588e9bed3a2e9c2b20a91533229f5406caa9ab67a77c87bcb455b7e85df11dcad3e3c3a9318c118ad09e1c3c1ab1511c6911f55b81d1f98982b9d189fc91a6d3c79003a75882b8001a4fe621eab8b48d256f82991d821ec96367c1bfd5cef01017a7fc16a8accb4a6558d67b934d2a4d0f2f4c3061d8ba40f8788f6a3ba1f8e064c1fe102ec0ba3e135959753502384222b8981f97a</KeyCode>
		    </LicenseContract>
		    """
		let trialLicenceKey = """
    		<LicenseContract>
    		<Customer>patrick.sluth@ucalgary.ca</Customer>
    		<OrderId>Trial</OrderId>
    		<LicenseCount>1</LicenseCount>
    		<IsTrialLicense>true</IsTrialLicense>
    		<SupportExpires>11/20/2018 00:00:00</SupportExpires>
    		<ProductCode>SC-IOS-2D-ENTERPRISE-SRC</ProductCode>
    		<KeyCode>af9535e4b2b68813af5f426810e8e78bb2a933d0221dd950f6869305770600d93751e26fcbddc45b47759ac2d03e3f4c459ede80682ae0ee2c76f473de75071b0a891fc24d2ff6cff83c839868d317bfee21138072359504326246bed74fd4bd1ca57969e414b29941a3ef836bf1996fda48b986cd444c7ef78808a7d0b70a8b76f77d0c313cc26698c145683acc6f3fae88ef9400402915e2125f33f2de56803a6b76c7bae91e797a93cae476d19c</KeyCode>
    		</LicenseContract>
    		"""
		
		SCIChartSurface.setRuntimeLicenseKey(trialLicenceKey)
		SCIChartSurface.setDisplayLinkRunLoopMode(.common)
	}
}




