//
//  APIClient.swift
//  YandexTask
//
//  Created by Максим Сурков on 07.03.2021.
//


import Foundation

protocol NetworkServiceProtocol{
    func getStocksData(completion: @escaping (Result<[ModelStock], Error>) -> Void)
    func getLogoUrl(for symbol: String, completion: @escaping (Result<ModelLogo, Error>) -> Void)
    //func fetchDataImage(url: URL, completion: @escaping (Result<Data , Error>) -> Void)
    func fetchNewsData(for symbol: String, completion: @escaping (Result<[NewsElement], Error>) -> Void)
    func fetchAboutCompanyData(for symbol: String, completion: @escaping (Result<ModelAbout, Error>) -> Void)
    var defalulturlNews: URL {get}
}

class APIClient {
    
    private var dataTask: URLSessionDataTask?
    
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
    
    var defalulturlNews: URL {
        return URL(string: "https://us.123rf.com/450wm/alhovik/alhovik1709/alhovik170900031/86481591-stock-vector-breaking-news-background-world-global-tv-news-banner-design.jpg?ver=6")!
    }
}
extension APIClient: NetworkServiceProtocol{
    
//    func fetchDataImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
//        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//               print("DataTask error (fetchDataLogo): \(error.localizedDescription)")
//               return
//            }
//            guard let data = data else {
//               print("Empty Response (fetchDataLogo)")
//               return
//            }
//            completion(.success(data))
//        }
//        dataTask?.resume()
//    }
    func fetchNewsData(for symbol: String, completion: @escaping (Result<News, Error>) -> Void){
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
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(News.self, from: data)
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
    func fetchAboutCompanyData(for symbol: String, completion: @escaping (Result<ModelAbout, Error>) -> Void){
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
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ModelAbout.self, from: data)
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
    
    func getLogoUrl(for symbol: String, completion: @escaping (Result<ModelLogo, Error>) -> Void){
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
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ModelLogo.self, from: data)
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
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ListStock.self, from: data)
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

