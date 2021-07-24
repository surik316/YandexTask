//
//  Colors.swift
//  YandexTask
//
//  Created by Максим Сурков on 08.07.2021.
//

import Foundation


import UIKit

struct Colors {
    static var evenCellColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { tc -> UIColor in
                return StockStyle.isLight(traitCollection: tc) ? UIColor.rgba(240, 244, 247) : UIColor.rgba(69, 70, 71)
            }
        } else {
            return StockStyle.isLight() ? UIColor.rgba(240, 244, 247) : UIColor.rgba(69, 70, 71)
        }
    }
    static var oddCellColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { tc -> UIColor in
                return StockStyle.isLight(traitCollection: tc) ? .white:  UIColor.rgba(32, 28, 26)
            }
        } else {
            return  StockStyle.isLight() ? .white:  UIColor.rgba(32, 28, 26)
        }
    }
    static var newsDescriptionColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { tc -> UIColor in
                return StockStyle.isLight(traitCollection: tc) ? UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1):  UIColor.rgba(69, 70, 71)
            }
        } else {
            return  StockStyle.isLight() ? UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1):  UIColor.rgba(69, 70, 71)
        }
    }
    static var backgroundColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { tc -> UIColor in
                return StockStyle.isLight(traitCollection: tc) ? .white:  UIColor.rgba(32, 28, 26)
            }
        } else {
            return  StockStyle.isLight() ? .white: UIColor.rgba(32, 28, 26)
        }
    }
    static var unselectedLabelColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { tc -> UIColor in
                return StockStyle.isLight(traitCollection: tc) ? UIColor.rgba(186, 186, 186): UIColor.rgba(225, 227, 230)
            }
        } else {
            return  StockStyle.isLight() ? UIColor.rgba(186, 186, 186): UIColor.rgba(225, 227, 230)
        }
    }
    static var selectedLabelColor: UIColor {
        if #available(iOS 13, *) {
            return UIColor.init { tc -> UIColor in
                return StockStyle.isLight(traitCollection: tc) ? .black :  UIColor.rgba(225, 227, 230)
            }
        } else {
            return  StockStyle.isLight() ?  .black :  UIColor.rgba(225, 227, 230)
        }
    }

}
class StockStyle {
    private init() {}
    
    static func isLight( traitCollection: UITraitCollection? = nil ) -> Bool {

        if #available(iOS 12.0, *) {
            return traitCollection?.userInterfaceStyle != .dark
        } else {
            return true
        }
    }
}
