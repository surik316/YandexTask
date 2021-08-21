//
//  StockModel+CoreDataProperties.swift
//  YandexTask
//
//  Created by maksim.surkov on 21.08.2021.
//
//

import Foundation
import CoreData


extension StockModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StockModel> {
        return NSFetchRequest<StockModel>(entityName: "StockModel")
    }

    @NSManaged public var change: Double
    @NSManaged public var changePercent: Double
    @NSManaged public var companyName: String?
    @NSManaged public var iexClose: Double
    @NSManaged public var iexOpen: Double
    @NSManaged public var isFavourite: Bool
    @NSManaged public var latestPrice: Double
    @NSManaged public var previousClose: Double
    @NSManaged public var symbol: String?
    @NSManaged public var image: Data?

}

extension StockModel : Identifiable {

}
