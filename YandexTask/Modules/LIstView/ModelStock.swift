//
//  ModelStock.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import Foundation
import  UIKit

struct ModelStock: Codable {
    let symbol, companyName, primaryExchange: String
    let latestPrice: Double?
    let latestTime: String
    let latestUpdate: Int?
    let previousClose: Double?
    let previousVolume: Int?
    let change, changePercent: Double?
    let avgTotalVolume: Int?
    let iexOpen: Double?
    let iexOpenTime: Int?
    let iexClose: Double?
    let iexCloseTime, marketCap: Int?
    let week52High, week52Low, ytdChange: Double?
    var logo: Data?
}

typealias ListStock = [ModelStock]

struct ModelLogo: Codable {
    let url: String
}

