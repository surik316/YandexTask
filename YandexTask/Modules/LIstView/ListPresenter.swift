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
        let isFavDict = Services.userDefaults.get(for: "isFavourite")
        for var element in storageStocks {
            if  isFavDict[element.symbol] != nil {
                element.isFavourite = true
            }
        }
    }
    private func networkLoad() {
        Services.network.getStocksData() { [weak self] (result) in
            guard let self = self else {return }
            switch result{
            case .success(let stocks):
                self.storageStocks = stocks
                let isFavDict = Services.userDefaults.get(for: "isFavourite")
                for var element in self.storageStocks {
                    if  isFavDict[element.symbol] != nil {
                        element.isFavourite = true
                    }
                }
                self.view?.sucess()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func getStocksImage(symbol: String, completion: @escaping (Result<URL?,Error>) -> ()) {
        Services.network.getLogoUrl(for: (symbol)) { (result)  in

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
