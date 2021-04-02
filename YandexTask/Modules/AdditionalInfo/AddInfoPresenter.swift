//
//  AddInfoPresenter.swift
//  YandexTask
//
//  Created by Максим Сурков on 26.03.2021.
//

import Foundation

protocol AddInfoViewProtocol: class{
    func succes(model: ModelStock)
    func gotNews()
    func failure(error: Error)
}

protocol AddInfoPresenterProtocol: class {
    init(view: AddInfoViewProtocol, networkService: NetworkServiceProtocol, model: ModelStock)
    func setView()
    func getNewsData()
    func getTitles() -> [String]
    func getStorageCount() -> Int?
    var storageNews: [NewsElement]? {get set}
    //func getNewsImage(url: String,  completion: @escaping (Result<Data,Error>) -> ())
}

class AddInfoPresenter: AddInfoPresenterProtocol {
    
    weak var view: AddInfoViewProtocol?
    var apiClient : NetworkServiceProtocol!
    var modelStock: ModelStock?
    var storageNews : [NewsElement]?
    var storageAbout: ModelAbout?
    let segmentTitles = ["Chart", "Summary", "News", "Forecasts", "Ideas"]
    
    required init(view: AddInfoViewProtocol, networkService: NetworkServiceProtocol, model: ModelStock) {
        self.view = view
        self.apiClient = networkService
        self.modelStock = model
    }
    public func setView(){
        self.view?.succes(model: modelStock!) //сделать дефолтную модель
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
//    func getNewsImage(url: String,  completion: @escaping (Result<Data,Error>) -> ()) {
//        let urlNews = URL(string: url )  ?? apiClient.defalulturlNews
//        apiClient.fetchDataImage(url: urlNews) { (result) in
//                switch result{
//                case.success(let data):
//                    DispatchQueue.main.async {
//                        completion(.success(data))
//                    }
//                case .failure(let error):
//                    print("apiClinetLOAD:\(error.localizedDescription)")
//                }
//        }
//    }
    func getAboutCompanyData() {
        apiClient.fetchAboutCompanyData(for: modelStock?.symbol ?? "") { (result) in
            switch result {
            case .success(let aboutCompanyData):
                self.storageAbout = aboutCompanyData
                //self.view?.gotNews()
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
