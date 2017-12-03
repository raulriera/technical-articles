//
//  AppDelegate.swift
//  Project-01
//
//  Created by Raul Riera on 2017-12-02.
//  Copyright © 2017 Raul Riera. All rights reserved.
//

import UIKit
import FunctionalTableData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		window = UIWindow()
		let rootViewController = UINavigationController(rootViewController: MoviesViewController())
		window?.rootViewController = rootViewController
		window?.makeKeyAndVisible()
		
		UIWindow.appearance().tintColor = .blue
		UIButton.appearance().setTitleColor(.blue, for: [])
		// Customize the appearance of the row separators
		Separator.appearance().backgroundColor = UITableView().separatorColor
		Separator.inset = 16
		
		return true
	}
}

