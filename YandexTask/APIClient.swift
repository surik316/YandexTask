//
//  APIClient.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//
import Foundation
import CoreData

protocol NetworkServiceProtocol{
    func getStocksData(completion: @escaping (Result<[ModelStock], Error>) -> Void)
    func getLogoUrl(for symbol: String, completion: @escaping (Result<ModelLogo, Error>) -> Void)
    func fetchNewsData(for symbol: String, completion: @escaping (Result<[NewsElement], Error>) -> Void)
    func fetchAboutCompanyData(for symbol: String, completion: @escaping (Result<ModelAbout, Error>) -> Void)
    func fetchPreviousDayData(for symbol: String, completion: @escaping (Result<ModelPreviousDay, Error>) -> Void)
    var defalulturlNews: URL {get}
    func getDataForGraph()->[[Int]]
}

class APIClient {
    
    private var dataTask: URLSessionDataTask?
    private let decoder = JSONDecoder()
    private let context = CoreDataStack.shared.viewContext
    private let databaseService = DatabaseService(coreDataStack: CoreDataStack())
    private func makeNoticableUrl(for symbol: String) -> URL?{
        var result = URLComponents()
        result.scheme = "https"
        result.host = "cloud.iexapis.com"
        result.path = "/stable/stock/market/list/\(symbol)"
        result.query = "token=\(UserDefaults.standard.object(forKey: "apiToken") ?? "")"
        return result.url
    }
    
    private func makeLogoUrl(for symbol: String) -> URL? {
        var result = URLComponents()
        result.scheme = "https"
        result.host = "cloud.iexapis.com"
        result.path = "/stable/stock/\(symbol)/logo"
        result.query = "token=\(UserDefaults.standard.object(forKey: "apiToken") ?? "")"
        return result.url
    }
    private func makeNewsUrl(for symbol: String) -> URL? {
        var result = URLComponents()
        result.scheme = "https"
        result.host = "cloud.iexapis.com"
        result.path = "/stable/stock/\(symbol)/news"
        result.query = "token=\(UserDefaults.standard.object(forKey: "apiToken") ?? "")"
        return result.url
    }
    private func makeAboutCompanyUrl(for symbol: String) -> URL? {
        var result = URLComponents()
        result.scheme = "https"
        result.host = "cloud.iexapis.com"
        result.path = "/stable/stock/\(symbol)/company"
        result.query = "token=\(UserDefaults.standard.object(forKey: "apiToken") ?? "")"
        return result.url
    }
    
    private func makePreviousDayUrl(for symbol: String) -> URL? {
        var result = URLComponents()
        result.scheme = "https"
        result.host = "cloud.iexapis.com"
        result.path = "/stable/stock/\(symbol)/previous"
        result.query = "token=\(UserDefaults.standard.object(forKey: "apiToken") ?? "")"
        return result.url
    }
    
    var defalulturlNews: URL {
        return URL(string: "https://us.123rf.com/450wm/alhovik/alhovik1709/alhovik170900031/86481591-stock-vector-breaking-news-background-world-global-tv-news-banner-design.jpg?ver=6")!
    }
}
extension APIClient: NetworkServiceProtocol{
    
    func fetchPreviousDayData(for symbol: String, completion: @escaping (Result<ModelPreviousDay, Error>) -> Void) {
        let newsURL = makePreviousDayUrl(for: symbol)
        dataTask = URLSession.shared.dataTask(with: newsURL!) { (data, response, error) in
            
            if let error = error {
               print("DataTask error: \(error.localizedDescription)")
               return
            }
            guard let data = data else {
               print("Empty Response")
               return
            }
            do {
                let jsonData = try self.decoder.decode(ModelPreviousDay.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    func getDataForGraph()->[[Int]] {
        let graphData = [[1,2,3,4,5,6,7,6,5,4,10,5,6],
                         [10,1,4,5,6,3,2,1,5,6],
                         [1,6,7,2,3,4,5,7,3,4,1],
                         [1,4,5,6,2,3,4,5,5,6,2],
                         [10,3,4,4,12,2,3,5,5,3],
                         [1,4,5,6,7,2,3,1,3,10,1],
                         [1,6,7,2,3,4,5,7,3,4,1],
                         [1,4,5,6,2,3,4,5,5,6,2],
                         [1,4,6,7,2,3,1,5,7,8,8],
                         [1,4,6,7,2,3,1,5,7,8,8],
                         [1,4,6,7,2,3,1,5,7,8,8],
                         [1,4,6,7,2,3,1,5,7,8,8]
                         
        ]
        return graphData
    }
    func fetchNewsData(for symbol: String, completion: @escaping (Result<News, Error>) -> Void) {
        let newsURL = makeNewsUrl(for: symbol)
        dataTask = URLSession.shared.dataTask(with: newsURL!) { (data, response, error) in
            
            if let error = error {
               print("DataTask error: \(error.localizedDescription)")
               return
            }
            guard let data = data else {
               print("Empty Response")
               return
            }
            do {
                let jsonData = try self.decoder.decode(News.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    func fetchAboutCompanyData(for symbol: String, completion: @escaping (Result<ModelAbout, Error>) -> Void) {
        let newsURL = makeAboutCompanyUrl(for: symbol)
        dataTask = URLSession.shared.dataTask(with: newsURL!) { (data, response, error) in
            
            if let error = error {
               print("DataTask error: \(error.localizedDescription)")
               return
            }
            guard let data = data else {
               print("Empty Response")
               return
            }
            do {
                let jsonData = try self.decoder.decode(ModelAbout.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func getLogoUrl(for symbol: String, completion: @escaping (Result<ModelLogo, Error>) -> Void) {
        let stockURL = makeLogoUrl(for: symbol)
        dataTask = URLSession.shared.dataTask(with: stockURL!) { (data, response, error) in
            
            if let error = error {
               print("DataTask error: \(error.localizedDescription)")
               return
            }
            guard let data = data else {
               print("Empty Response")
               return
            }
            do {
                let jsonData = try self.decoder.decode(ModelLogo.self, from: data)
                completion(.success(jsonData))
            }
            catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func getStocksData(completion: @escaping (Result<[ModelStock], Error>) -> Void) {
        let stockURL = makeNoticableUrl(for: "iexvolume?")
            dataTask = URLSession.shared.dataTask(with: stockURL!) { (data, response, error) in
                if let error = error {
                   print("DataTask error: \(error.localizedDescription)")
                   return
                }
               guard let response = response as? HTTPURLResponse, let data = data else {
                   print("Empty Response")
                   return
               }
               print("Response status code: \(response.statusCode)")
               do {
                let jsonData = try self.decoder.decode([ModelStock].self, from: data)
                self.databaseService.deleteAllData(entity: "StockModel")
                self.databaseService.update(stoks: jsonData)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
               }
               catch let error {
                    completion(.failure(error))
               }
            }
            dataTask?.resume()
        }
}

