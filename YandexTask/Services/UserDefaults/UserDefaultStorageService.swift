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
    
    func get(for key: TypeOfStorage) -> [String: Bool] {
        guard let data = defaults.object(forKey: key.rawValue) as? [String: Bool] else {
            return [:]
        }
        return  data
    }
    func updateValue(symbol: String, value: Bool, key: TypeOfStorage) {

        var dictOfFavourites: [String: Bool] = defaults.object(forKey: key.rawValue) as? [String: Bool] ?? [String: Bool]()
        dictOfFavourites[symbol] = value
        defaults.set(dictOfFavourites, forKey: "isFavourite")
    }
    func remove(for key: String) {
        defaults.removeObject(forKey: key)
    }
}
