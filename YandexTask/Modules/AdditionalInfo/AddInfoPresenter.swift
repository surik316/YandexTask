//
//  AddInfoPresenter.swift
//  YandexTask
//
//  Created by Максим Сурков on 26.03.2021.
//

import Foundation

protocol AddInfoViewProtocol: AnyObject {
    func succes(model: ModelStock)
    func gotNews()
    func gotAbout()
    func gotPreviousDay()
    func failure(error: Error)
}

protocol AddInfoPresenterProtocol: AnyObject {
    init(view: AddInfoViewProtocol, model: ModelStock)
    func setView()
    func getNewsData()
    func getTitles() -> [String]
    func getStorageCount() -> Int?
    func getAboutCompanyData()
    func getPreviousDayData()
    func getGraphData()
    var storageNews: [NewsElement]? {get}
    var storageAbout: ModelAbout? {get}
    var storageGraph: [[Int]]? {get}
    var storagePreviousDay: ModelPreviousDay? {get}
    var modelStock: ModelStock {get}
}

class AddInfoPresenter: AddInfoPresenterProtocol {
    
    weak var view: AddInfoViewProtocol?
    var modelStock: ModelStock
    var storageNews: [NewsElement]?
    var storageAbout: ModelAbout?
    var storagePreviousDay: ModelPreviousDay?
    var storageGraph: [[Int]]?
    let segmentTitles = [ "News", "About", "PrevDay", "Chart"]
    
    required init(view: AddInfoViewProtocol, model: ModelStock) {
        self.view = view
        self.modelStock = model
    }
    public func setView() {
        self.view?.succes(model: modelStock)
    }
    func getNewsData() {
        Services.network.fetchNewsData(for: modelStock.symbol) { (result) in
            switch result {
            case .success(let news):
                self.storageNews = news
                self.view?.gotNews()
            case .failure(let error):
                print("fetchNewsData Error: \(error)")
            }
        }
    }
    func getGraphData() {
        storageGraph =  Services.network.getDataForGraph()
    }
    func getPreviousDayData() {
        Services.network.fetchPreviousDayData(for: modelStock.symbol) { (result) in
            switch result {
            
            case .success(let previousDayData):
                self.storagePreviousDay = previousDayData
                self.view?.gotPreviousDay()
            case .failure(let error):
                print("fetctFinancialData Error: \(error)")
            }
        }
    }
    func getAboutCompanyData() {
        Services.network.fetchAboutCompanyData(for: modelStock.symbol) { (result) in
            switch result {
            case .success(let aboutCompanyData):
                self.storageAbout = aboutCompanyData
                self.view?.gotAbout()
            case .failure(let error):
                print("fetchNewsData Error: \(error)")
            }
        }
    }
    func getTitles() -> [String] {
        return segmentTitles
    }
    
    func getStorageCount() -> Int? {
        return storageNews?.count
    }
    
}
