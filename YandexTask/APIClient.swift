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
    func fetchDataLogo(url: URL, completion: @escaping (Result<Data , Error>) -> Void)
}

class APIClient {
    
    private var dataTask: URLSessionDataTask?
    
    private func makeNoticableUrl(for symbol: String) -> URL?{
        let token = "pk_395e07bffa824330b9708189588cc026"
        var result = URLComponents()
        result.scheme = "https"
        result.host = "cloud.iexapis.com"
        result.path = "/stable/stock/market/list/\(symbol)"
        result.query = "token=\(token)"
        return result.url
    }
    
    private func makeLogoUrl(for symbol: String) -> URL? {
        var result = URLComponents()
        let token = "pk_395e07bffa824330b9708189588cc026"
        result.scheme = "https"
        result.host = "cloud.iexapis.com"
        result.path = "/stable/stock/\(symbol)/logo"
        result.query = "token=\(token)"
        return result.url
    }
}

extension APIClient: NetworkServiceProtocol{
    
    func fetchDataLogo(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
               print("DataTask error (fetchDataLogo): \(error.localizedDescription)")
               return
            }
            guard let data = data else {
               print("Empty Response (fetchDataLogo)")
               return
            }
            completion(.success(data))
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
            //print("Response status code: \(response.statusCode)")
            do {
                let decoder = JSONDecoder()
                //print(String(decoding: data, as: UTF8.self))
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
               // print(String(decoding: data, as: UTF8.self))
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

