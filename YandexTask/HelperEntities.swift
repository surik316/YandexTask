//
//  HelperEntities.swift
//  YandexTask
//
//  Created by Максим Сурков on 08.03.2021.
//

import Foundation

enum RequestError: Error {
    case url
    case decoding
    case encoding
    case network
    case keychain
    case emailInUse
    case serverInternal
}
