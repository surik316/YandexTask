//
//  AddInfoPresenter.swift
//  YandexTask
//
//  Created by Максим Сурков on 26.03.2021.
//

import Foundation

protocol AddInfoViewProtocol: AnyObject{
    func succes(model: ModelStock)
    func gotNews()
    func gotAbout()
    func gotPreviousDay()
    func failure(error: Error)
}

protocol AddInfoPresenterProtocol: AnyObject {
    init(view: AddInfoViewProtocol, networkService: NetworkServiceProtocol, model: ModelStock)
    func setView()
    func getNewsData()
    func getTitles() -> [String]
    func getStorageCount() -> Int?
    func getAboutCompanyData()
    func getPreviousDayData()
    var storageNews: [NewsElement]? {get}
    var storageAbout: ModelAbout? {get}
    var storagePreviousDay: ModelPreviousDay? {get}
}

class AddInfoPresenter: AddInfoPresenterProtocol {
    
    weak var view: AddInfoViewProtocol?
    var apiClient : NetworkServiceProtocol!
    var modelStock: ModelStock?
    var storageNews : [NewsElement]?
    var storageAbout: ModelAbout?
    var storagePreviousDay: ModelPreviousDay?
    let segmentTitles = [ "News", "About", "PreviousDay", "Chart"]
    
    required init(view: AddInfoViewProtocol, networkService: NetworkServiceProtocol, model: ModelStock) {
        self.view = view
        self.apiClient = networkService
        self.modelStock = model
    }
    public func setView(){
        self.view?.succes(model: modelStock ?? ModelStock()) //сделать дефолтную модель
    }
    func getNewsData() {
        apiClient.fetchNewsData(for: modelStock?.symbol ?? "") { (result) in
            switch result {
            case .success(let news):
                self.storageNews = news
                self.view?.gotNews()
            case .failure(let error):
                print("fetchNewsData Error: \(error)")
            }
        }
    }
    func getPreviousDayData() {
        apiClient.fetchPreviousDayData(for: modelStock?.symbol ?? "") { (result) in
            switch result{
            
            case .success(let previousDayData):
                self.storagePreviousDay = previousDayData
                self.view?.gotPreviousDay()
            case .failure(let error):
                print("fetctFinancialData Error: \(error)")
            }
        }
    }
    func getAboutCompanyData() {
        apiClient.fetchAboutCompanyData(for: modelStock?.symbol ?? "") { (result) in
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
