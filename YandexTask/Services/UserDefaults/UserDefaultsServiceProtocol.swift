//
//  UserDefaultsServiceProtocol.swift
//  YandexTask
//
//  Created by maksim.surkov on 22.08.2021.
//

import Foundation

protocol StorageServiceProtocol: AnyObject {
    func save(object: [String: Bool], for key: String)
    func get(for key: String) -> [String: Bool]
    func remove(for key: String)
}
