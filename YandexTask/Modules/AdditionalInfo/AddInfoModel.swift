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

struct ModelPreviousDay: Codable {
    let closePrice: Double?
    let highPrice, lowPrice, openPrice: Double?

    enum CodingKeys: String, CodingKey {
        case closePrice = "close"
        case highPrice = "high"
        case lowPrice = "low"
        case openPrice = "open"
    }
}

extension UILabel {
  func addCharacterSpacing(kernValue: Double = 1.15) {
    if let labelText = text, labelText.count > 0 {
      let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSRange(location: 0, length: attributedString.length - 1))
      attributedText = attributedString
    }
  }
}
