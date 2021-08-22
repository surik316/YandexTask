//
//  Services.swift
//  YandexTask
//
//  Created by maksim.surkov on 22.08.2021.
//

import Foundation

struct Services {
    static let network = Network()
    static let coreData = DatabaseService(coreDataStack: CoreDataStack())
    static let userDefaults = UserDefaultStorageService()
    static let networkConnection = AccessibilityService()
}
