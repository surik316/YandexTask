//
//  ListProtocols.swift
//  YandexTask
//
//  Created by maksim.surkov on 22.08.2021.
//

import Foundation

protocol ListViewProtocol: AnyObject{
    func sucess()
    func failure(error: Error)
}

protocol ListViewPresenterProtocol: AnyObject {
    init(view: ListViewProtocol)
    func getStocksImage(symbol: String, completion: @escaping (Result<URL?,Error>) -> ())
    func filterStorageStocks(searchText: String)
    var storageStocks: [ModelStock] {get set}
    var filteredStocks: [ModelStock]? {get set}
    var storageLikedStocks: [ModelStock] {get set}
    var isLableTappedFavourite: Bool {get}
    func changeStateLableFavourite(state: Bool)
    func load()
}
