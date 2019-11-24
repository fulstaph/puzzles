//
//  AppDelegate.swift
//  Puzzles
//
//  Created by Leonid Serebryanyy on 18.11.2019.
//  Copyright © 2019 Leonid Serebryanyy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var networkService: NetworkService?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		
		let networkService = NetworkService()
		let rootViewController = ViewController(networkService: networkService)
		self.networkService = networkService
		
		window?.rootViewController = rootViewController
		window?.makeKeyAndVisible()
		return true
	}
}

