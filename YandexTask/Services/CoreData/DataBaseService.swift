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
//        let stock = StockModel(context: backgroundContext)
//        stock.symbol = stoks[0].symbol
        
        //backgroundContext.perform {
            stoks.forEach {
                let stock = StockModel(context: backgroundContext)
                stock.update(with: $0)
            }
       // }
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Error saving while updating objects \(error.localizedDescription)")
            }
        }
    }
    
    func getStonks() -> [ModelStock] {
        var result = [ModelStock]()
        let context = coreDataStack.viewContext
        
        let request: NSFetchRequest<StockModel> = StockModel.fetchRequest()
        request.returnsObjectsAsFaults = false
        context.performAndWait {
            guard let response = try? context.fetch(request) else { return }
            result = response.map { ModelStock(with: $0) }
        }
        
        return  result
    }
    func deleteAllData(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do
        {
            try self.coreDataStack.backgroundContext.execute(deleteRequest)
            try self.coreDataStack.backgroundContext.save()
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
        self.latestPrice = stock.latestPrice ?? 0.0
        
    }
}
private extension ModelStock {
    init(with stock: StockModel, isFavorite: Bool? = nil) {
        
        self.symbol = stock.symbol ?? ""
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
public extension NSManagedObject {

    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }

}
