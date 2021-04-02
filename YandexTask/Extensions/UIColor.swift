//
//  UIColor.swift
//  YandexTask
//
//  Created by Максим Сурков on 02.04.2021.
//

import Foundation
import UIKit


extension UIColor {
    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
