//
//  ListPresenter.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import Foundation
import UIKit

protocol ListViewProtocol: class{
    func succes()
    func failure(error: Error)
}

protocol ListViewPresenterProtocol: class {
    init(view: ListViewProtocol, networkService: NetworkServiceProtocol)
    func fetchStockData(completion: @escaping () -> ())
    func fetchStocksImage(symbol: String, completion: @escaping (Result<URL?,Error>) -> ())
    var storageStocks: [ModelStock] {get set}
    var storageLikedStocks: [ModelStock] {get set}
}

class ListPresenter: ListViewPresenterProtocol {
    

    weak var view: ListViewProtocol?
    var apiClient : NetworkServiceProtocol!
    var storageStocks = [ModelStock]()
    var storageLikedStocks = [ModelStock]()
    
    let defaultUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/768px-No_image_available.svg.png")
    required init(view: ListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.apiClient = networkService
    }
    
    func fetchStockData(completion: @escaping () -> ()) {
            apiClient.getStocksData() { [weak self] (result) in
                guard let self = self else {return }
                switch result{
                case .success(let stocks):
                    self.storageStocks = stocks
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
    }
    
    func fetchStocksImage(symbol: String, completion: @escaping (Result<URL?,Error>) -> ()) {
        self.apiClient.getLogoUrl(for: (symbol)) { (result)  in

            switch result{
            case .success(let logo):
                completion(.success(URL(string: logo.url)))
            case .failure(let error):

                print("LOGO:\(error.localizedDescription)")
            }
        }
    }
}
