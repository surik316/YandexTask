//
//  CoreDataStack.swift
//  YandexTask
//
//  Created by maksim.surkov on 15.08.2021.
//

import Foundation
import CoreData


class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var viewContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    lazy var backgroundContext: NSManagedObjectContext =  {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "StockModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        })
        return container
    }()
    func saveContext () {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
          do {
            try context.save()
          } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
        }
    }
}
