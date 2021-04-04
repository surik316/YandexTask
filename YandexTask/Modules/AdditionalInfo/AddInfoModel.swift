//
//  AddInfoModel.swift
//  YandexTask
//
//  Created by Максим Сурков on 26.03.2021.
//

import Foundation
import UIKit

struct NewsElement: Codable {
    let datetime: Int
    let headline, source: String
    let url, summary: String
    let related: String?
    let image: String
}

typealias News = [NewsElement]


struct ModelAbout: Codable {
    let symbol, companyName, industry: String
    let website: String
    let description, securityName, sector, address: String
    let state, city, zip, country: String
    let phone: String
}
struct ModelFinancial: Codable {
    let accountsPayableCurrent, accountsReceivableNetCurrent, accruedIncomeTaxesNoncurrent: Int

    enum CodingKeys: String, CodingKey {
        case accountsPayableCurrent = "AccountsPayableCurrent"
        case accountsReceivableNetCurrent = "AccountsReceivableNetCurrent"
        case accruedIncomeTaxesNoncurrent = "AccruedIncomeTaxesNoncurrent"
    }
}

typealias Financials = [ModelFinancial]
