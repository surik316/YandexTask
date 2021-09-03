//
//  Extensions.swift
//  YandexTask
//
//  Created by Максим Сурков on 29.03.2021.
//

import Foundation

func constist(arrayStocks: [ModelStock], stock: ModelStock) -> Bool {
    for item in arrayStocks where item.companyName == stock.companyName {
        return true
    }
    return false
}

func delete( arrayStocks: inout [ModelStock], stock: ModelStock) {
    if let index = arrayStocks.firstIndex(where: {$0.companyName == stock.companyName}) {
        arrayStocks.remove(at: index)
    }
}

func change_isFavourite(arrayStocks: inout [ModelStock], stock: ModelStock) {
    if let index = arrayStocks.firstIndex(where: {$0.companyName == stock.companyName}) {
        arrayStocks[index].isFavourite = false
    }
}
