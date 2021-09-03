//
//  ListPresenter.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//

import Foundation
import UIKit

class ListPresenter: ListViewPresenterProtocol {
   
    private weak var view: ListViewProtocol?
    var storageStocks = [ModelStock]()
    var storageLikedStocks = [ModelStock]()
    var filteredStocks: [ModelStock]?
    private(set) var isLableTappedFavourite = false
    required init(view: ListViewProtocol) {
        self.view = view
        Services.networkConnection.start()
    }

    func load() {
        if Services.networkConnection.isNetworkAccessable {
            networkLoad()
        } else {
            offlineLoad()
        }
    }
    private func offlineLoad() {
        storageStocks = []
        storageStocks = Services.coreData.getStonks()
        let isFavDict = Services.userDefaults.get(for: .favourite)
        for  element in storageStocks where isFavDict[element.symbol] != nil {
            if let index = storageStocks.firstIndex(where: { $0.symbol == element.symbol }) {
                storageStocks[index].isFavourite = isFavDict[element.symbol]
            }
        }
    }
    private func networkLoad() {
        Services.network.getStocksData { [weak self] (result) in
            guard let self = self else {return }
            switch result {
            case .success(var stocks):
                let isFavDict = Services.userDefaults.get(for: .favourite)
                for  element in stocks where isFavDict[element.symbol] != nil {
                    if let index = stocks.firstIndex(where: { $0.symbol == element.symbol }) {
                        stocks[index].isFavourite = isFavDict[element.symbol]
                    }
                }
                self.storageStocks = stocks
                self.view?.sucess()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func getStocksImage(symbol: String, completion: @escaping (Result<URL?, Error>) -> Void) {
        Services.network.getLogoUrl(for: (symbol)) { (result)  in

            switch result {
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
