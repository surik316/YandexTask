//
//  AppDelegate.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import UIKit
import CoreData

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
        UserDefaults.standard.setValue("sk_37ca0f740a514ca48f1c08863ad7295a", forKey: "apiToken")
        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.shared.saveContext()
    }

}
