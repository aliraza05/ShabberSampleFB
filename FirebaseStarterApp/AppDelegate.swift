//
//  AppDelegate.swift
//  FirebaseStarterApp
//
//  Created by Florian Marcu on 2/21/19.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Window setup
        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = UINavigationController(rootViewController: ATCClassicLandingScreenViewController(nibName: "ATCClassicLandingScreenViewController", bundle: nil))
        window?.rootViewController = UINavigationController(rootViewController: ATCClassicLoginScreenViewController(nibName: "ATCClassicLoginScreenViewController", bundle: nil))

        window?.makeKeyAndVisible()
        return true
    }
}

