//
//  AppDelegate.swift
//  FoodClassifiication
//
//  Created by Тимофей Борисов on 02.06.2023.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


	var window: UIWindow?
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)

		let vc = Main.Controller()
		let navigationVC = NavigationController(rootViewController: vc)
		navigationVC.navigationBar.backgroundColor = .white
		window?.rootViewController = navigationVC

		FirebaseApp.configure()
		if !UserDefaults.standard.bool(forKey: "logged_in") {
			
		}
		window?.makeKeyAndVisible()
		return true
	}
}

