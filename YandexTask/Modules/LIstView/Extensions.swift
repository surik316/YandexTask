//
//  Extensions.swift
//  YandexTask
//
//  Created by Максим Сурков on 29.03.2021.
//

import Foundation

func constist(arrayStocks: [ModelStock], stock: ModelStock) -> Bool{

    if arrayStocks.count == 0 {
        return false
    }
    else {
        for i in 0...arrayStocks.count - 1{
            if arrayStocks[i].companyName == stock.companyName {
                return true
            }
        }
    }
    return false
}
func delete( arrayStocks: inout [ModelStock], stock: ModelStock){
    if arrayStocks.count != 0 {
        for i in 0...arrayStocks.count - 1{
            if arrayStocks[i].companyName == stock.companyName {
                arrayStocks.remove(at: i)
                return
            }
        }
    }
}
