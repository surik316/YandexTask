//
//  NetworkProtocol.swift
//  YandexTask
//
//  Created by maksim.surkov on 22.08.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    func getStocksData(completion: @escaping (Result<[ModelStock], Error>) -> Void)
    func getLogoUrl(for symbol: String, completion: @escaping (Result<ModelLogo, Error>) -> Void)
    func fetchNewsData(for symbol: String, completion: @escaping (Result<[NewsElement], Error>) -> Void)
    func fetchAboutCompanyData(for symbol: String, completion: @escaping (Result<ModelAbout, Error>) -> Void)
    func fetchPreviousDayData(for symbol: String, completion: @escaping (Result<ModelPreviousDay, Error>) -> Void)
    var defalulturlNews: URL {get}
    func getDataForGraph() -> [[Int]]
}
