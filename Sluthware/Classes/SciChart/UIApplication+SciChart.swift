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
		    <Customer>pat.sluth@gmail.com</Customer>
		    <OrderId>Trial</OrderId>
		    <LicenseCount>1</LicenseCount>
		    <IsTrialLicense>true</IsTrialLicense>
		    <SupportExpires>02/11/2019 00:00:00</SupportExpires>
		    <ProductCode>SC-IOS-2D-ENTERPRISE-SRC</ProductCode>
		    <KeyCode>78dd1cce12ac22bee97134b771f0f5e1f51fccde1e36f5250f5c12fb0364653f96bb0e7719f6785c505ddbb2b9e0b87baf68ca3c9627b889d477c867cefa64f9a44b7a695538413bbc31a3ea03b1bdb0da30951a85b2e39a1b5d52a1be15fadb8a4757727c53c895547e1c85600844a03a7084e65daf6923f52a1573aea40fa0273083868cc5a6526dc3f7025e33597b9f0567d1bbacbe34c77ab3fa97b78782cbafddb966df37ea04</KeyCode>
		    </LicenseContract>
		    """
		
		SCIChartSurface.setRuntimeLicenseKey(trialLicenceKey)
		SCIChartSurface.setDisplayLinkRunLoopMode(.common)
	}
}




