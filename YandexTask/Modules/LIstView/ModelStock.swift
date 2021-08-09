//
//  ModelStock.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import Foundation
import  UIKit

struct ModelStock: Codable {
    let symbol, companyName: String
    let latestPrice: Double?
    let previousClose: Double?
    let change, changePercent: Double?
    let iexOpen: Double?
    let iexClose: Double?
    var isFavourite: Bool? = false;
    var tag: Int?
    init() {
        self.symbol = "SMTH"
        self.companyName = "someName"
        self.change = 111
        self.latestPrice = 111
        self.previousClose = 111
        self.changePercent = 0.1
        self.iexOpen = 111
        self.iexClose = 111
    }
}

typealias ListStock = [ModelStock]

struct ModelLogo: Codable {
    let url: String
}

