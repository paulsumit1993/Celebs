//
//  CoreDataManager.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager {
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Celebs")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func addToDataBase(celebrities: [Celebrity]) {
            persistentContainer.performBackgroundTask { context in
                for celebrity in celebrities {
                    let localCelebrity = SSCelebrity(context: context)
                    localCelebrity.fullName = celebrity.fullName
                    localCelebrity.emailId = celebrity.emailId
                    localCelebrity.imageUrl = celebrity.imageUrl
            }
            try? context.save()
        }
    }
    
    func saveContext() {
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
