//
//  AddInfoPresenter.swift
//  YandexTask
//
//  Created by Максим Сурков on 26.03.2021.
//

import Foundation

protocol AddInfoViewProtocol: class{
    func succes()
    func failure(error: Error)
}

protocol AddInfoPresenterProtocol: class {
    init(view: AddInfoViewProtocol, networkService: NetworkServiceProtocol)
}


class AddInfoPresenter: AddInfoPresenterProtocol {
    
    weak var view: AddInfoViewProtocol?
    var apiClient : NetworkServiceProtocol!
    
    required init(view: AddInfoViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.apiClient = networkService
    }
}
