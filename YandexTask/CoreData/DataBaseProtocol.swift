//
//  DataBaseProtocol.swift
//  YandexTask
//
//  Created by maksim.surkov on 15.08.2021.
//

import Foundation

protocol DatabaseServiceProtocol {
    func update(stoks: [ModelStock])
    func getStonks() -> [ModelStock]
}
