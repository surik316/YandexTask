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
    //let hasPaywall: UIImage?
}

typealias News = [NewsElement]


struct ModelAbout: Codable {
    let symbol, companyName, industry: String
    let website: String
    let welcomeDescription, securityName, sector, address: String
    let state, city, zip, country: String
    let phone: String

    enum CodingKeys: String, CodingKey {
        case symbol, companyName, industry, website
        case welcomeDescription = "description"
        case securityName, sector, address, state, city, zip, country, phone
    }
}
