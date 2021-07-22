//
//  ListBuilder.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import Foundation
import UIKit

protocol Builder {
    static func createModule() -> UIViewController
    static func createAddInfoModule(modelStock: ModelStock) -> UIViewController
}

class ListBuilder: Builder{
    static func createModule() -> UIViewController {
        let networkService = APIClient()
        let view = ListViewController()
        let presenter = ListPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    static func createAddInfoModule(modelStock: ModelStock) -> UIViewController {
        let networkService = APIClient()
        let view = AddInfoViewController()
        let presenter = AddInfoPresenter(view: view , networkService: networkService, model: modelStock)
        view.presenter = presenter
        return view
    }
}
