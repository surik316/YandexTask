//
//  UserDefaultsServiceProtocol.swift
//  YandexTask
//
//  Created by maksim.surkov on 22.08.2021.
//

import Foundation
enum TypeOfStorage: String {
    case favourite = "isFavourite"
}
protocol StorageServiceProtocol: AnyObject {
    func updateValue(symbol: String, value: Bool, key: TypeOfStorage)
    func save(object: [String: Bool], for key: String)
    func get(for key: TypeOfStorage) -> [String: Bool]
    func remove(for key: String)
}
