//
//  DataBaseService.swift
//  YandexTask
//
//  Created by maksim.surkov on 15.08.2021.
//

import Foundation
import CoreData

final class DatabaseService {
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
}

extension DatabaseService: DatabaseServiceProtocol {
    func update(stoks: [ModelStock]) {
        let backgroundContext = coreDataStack.backgroundContext
        backgroundContext.perform {
            stoks.forEach {
                let stock = StockModel(context: backgroundContext)
                stock.update(with: $0)
            }
        }
    }
    
    func getStonks() -> [ModelStock] {
        var result = [ModelStock]()
        let context = coreDataStack.viewContext
        
        let request: NSFetchRequest<StockModel> = StockModel.fetchRequest()
        
        context.performAndWait {
            guard let response = try? context.fetch(request) else { return }
            result = response.map { ModelStock(with: $0) }
        }
        
        return  result
    }
    func deleteAllData(entity: String)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false

        do
        {
            let results = try coreDataStack.viewContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                self.coreDataStack.viewContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    
}
private extension StockModel {
    func update(with stock: ModelStock) {
        self.symbol = stock.symbol
        self.change = stock.change ?? 0.0
        self.changePercent = stock.changePercent ?? 0.0
        self.companyName = stock.companyName
        self.iexClose = stock.iexClose ?? 0.0
        self.iexOpen = stock.iexOpen ?? 0.0
        self.isFavourite = stock.isFavourite ?? false
        self.previousClose = stock.previousClose ?? 0.0
        
    }
}
private extension ModelStock {
    init(with stock: StockModel, isFavorite: Bool? = nil) {
        
        self.symbol = stock.symbol!
        self.change = stock.change
        self.changePercent = stock.changePercent
        self.companyName = stock.companyName ?? ""
        self.iexClose = stock.iexClose
        self.iexOpen = stock.iexOpen
        self.isFavourite = stock.isFavourite
        self.latestPrice = stock.latestPrice
        self.previousClose = stock.previousClose
    }
}
