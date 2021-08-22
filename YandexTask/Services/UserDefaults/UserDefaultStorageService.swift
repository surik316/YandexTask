//
//  UserDefaultStorageService.swift
//  YandexTask
//
//  Created by maksim.surkov on 22.08.2021.
//

import Foundation

final class UserDefaultStorageService: StorageServiceProtocol {

    private let defaults: UserDefaults
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    convenience init() {
        self.init(defaults: UserDefaults.standard)
    }
    
    func save(object: [String: Bool], for key: String) {
        defaults.set(object, forKey: key)
    }
    
    func get(for key: String) -> [String: Bool] {
        guard let data = defaults.object(forKey: key) else {
            return [:]
        }
       
        return  data as? [String: Bool] ?? [:]
    }
    func updateValue(symbol: String, value: Bool) {
        var isFavouriteDict = defaults.object(forKey: "IsFavourite") as? [String: Bool] ?? [:]
        isFavouriteDict[symbol] = value
        defaults.set(isFavouriteDict, forKey: "IsFavourite")
    }
    func remove(for key: String) {
        defaults.removeObject(forKey: key)
    }
}
