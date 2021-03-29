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
    func fetchStocksImage(symbol: String, completion: @escaping (Result<Data,Error>) -> ())
    var storageStocks: [ModelStock] {get set}
    var storageLikedStocks: [ModelStock] {get set}
    func load(url: URL, completion: @escaping (Result<Data, Error>)->Void)
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
    func load(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        apiClient.fetchDataLogo(url: url) { (result) in
                
                switch result{
                case.success(let data):
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                case .failure(let error):
                    print("apiClinetLOAD:\(error.localizedDescription)")
                }
        }
    }
    func fetchStockData(completion: @escaping () -> ()){
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
    func fetchStocksImage(symbol: String, completion: @escaping (Result<Data,Error>) -> ()){
        self.apiClient.getLogoUrl(for: (symbol)) { [weak self] (result)  in

            guard let self = self else {return }
            switch result{
            case .success(let logo):

                self.load(url: URL(string: logo.url) ?? self.defaultUrl!, completion: completion)
                
            case .failure(let error):

                print("LOGO:\(error.localizedDescription)")
            }
        }
    }
}
