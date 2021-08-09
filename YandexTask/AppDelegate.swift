//
//  AppDelegate.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = ListBuilder.createModule()
        let navController = UINavigationController(rootViewController: viewController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = navController
        self.window = window
        UserDefaults.standard.setValue("sk_54429456ae874549bce0fafb459ec168", forKey: "apiToken")
        return true
    }


}

