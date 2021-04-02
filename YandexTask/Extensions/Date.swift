//
//  Date.swift
//  YandexTask
//
//  Created by Максим Сурков on 02.04.2021.
//

import Foundation

extension Date {
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        return dateFormatter.string(from: self)
    }
}
