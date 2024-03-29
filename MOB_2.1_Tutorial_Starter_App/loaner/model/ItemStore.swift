//
//  ItemStore.swift
//  loaner
//
//  Created by MattHew Phraxayavong on 6/27/19.
//  Copyright © 2019 LinnierGames. All rights reserved.
//

import UIKit
import CoreData



class ItemStore: NSObject {
    
    let persistentContainer: NSPersistentContainer = {
        //creates the NSPersistentContainer Object
        // must be given the name of the Core Data model file "LoanedItems"
        let container = NSPersistentContainer(name: "LoanedItems")
        // load the saved database if it exists, creates it if it does not, and returns an error under the failure conditions
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    func fetchPersistedData(completion: @escaping (FetchItemsResult) -> Void) {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let viewContext = persistentContainer.viewContext
        
        do {
            let allItems = try viewContext.fetch(fetchRequest)
            completion(.success(allItems))
        } catch {
            completion(.failure(error))
        }
    }
    // MARK: - Save Core Data Context
    func saveContext() {
        let viewContext = persistentContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
enum FetchItemsResult {
    case success([Item])
    case failure(Error)
}
