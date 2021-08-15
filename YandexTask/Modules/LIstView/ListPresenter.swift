//
//  ListPresenter.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import Foundation
import UIKit

protocol ListViewProtocol: AnyObject{
    func sucess()
    func failure(error: Error)
}

protocol ListViewPresenterProtocol: AnyObject {
    init(view: ListViewProtocol, networkService: NetworkServiceProtocol)
    func getStocksImage(symbol: String, completion: @escaping (Result<URL?,Error>) -> ())
    func filterStorageStocks(searchText: String)
    var storageStocks: [ModelStock] {get set}
    var filteredStocks: [ModelStock]? {get set}
    var storageLikedStocks: [ModelStock] {get set}
    var isLableTappedFavourite: Bool {get}
    func changeStateLableFavourite(state: Bool)
    func load()
}

class ListPresenter: ListViewPresenterProtocol {
   
    private weak var view: ListViewProtocol?
    var apiClient : NetworkServiceProtocol!
    var storageStocks = [ModelStock]()
    var storageLikedStocks = [ModelStock]()
    var filteredStocks: [ModelStock]?
    private(set) var isLableTappedFavourite = false
    private let databaseService = DatabaseService(coreDataStack: CoreDataStack())
    private let accessibilityService = AccessibilityService()
    required init(view: ListViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.apiClient = networkService
        accessibilityService.start()
    }

    func load() {
        if accessibilityService.isNetworkAccessable {
            networkLoad()
        } else {
            offlineLoad()
        }
    }
    private func offlineLoad() {
        storageStocks = databaseService.getStonks()
    }
    private func networkLoad() {
        apiClient.getStocksData() { [weak self] (result) in
            guard let self = self else {return }
            switch result{
            case .success(let stocks):
                self.storageStocks = stocks
                self.view?.sucess()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func getStocksImage(symbol: String, completion: @escaping (Result<URL?,Error>) -> ()) {
        self.apiClient.getLogoUrl(for: (symbol)) { (result)  in

            switch result{
            case .success(let logo):
                completion(.success(URL(string: logo.url)))
            case .failure(let error):

                print("LOGO:\(error.localizedDescription)")
            }
        }
    }
    func filterStorageStocks(searchText: String) {
        if isLableTappedFavourite {
            filteredStocks = storageLikedStocks.filter { stock in
                return stock.symbol.lowercased().contains(searchText.lowercased()) || stock.companyName.lowercased().contains(searchText.lowercased())
            }
        } else {
            filteredStocks = storageStocks.filter { stock in
                return stock.symbol.lowercased().contains(searchText.lowercased()) || stock.companyName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    func changeStateLableFavourite(state: Bool) {
        isLableTappedFavourite = state
    }
    
}
