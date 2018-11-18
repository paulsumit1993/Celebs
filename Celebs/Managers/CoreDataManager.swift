//
//  CoreDataManager.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import CoreData

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
    
    lazy var fetchedResultsController: NSFetchedResultsController<SSCelebrity> = {
        let fetchRequest: NSFetchRequest<SSCelebrity> = SSCelebrity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(SSCelebrity.emailId), ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    
    func addToDataBase(celebrities: [Celebrity], completion: @escaping (Bool) -> Void) {
        let context = fetchedResultsController.managedObjectContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.performAndWait {
            for celebrity in celebrities {
                let localCelebrity = SSCelebrity(context: context)
                localCelebrity.fullName = celebrity.fullName
                localCelebrity.emailId = celebrity.emailId
                localCelebrity.imageUrl = celebrity.imageUrl
            }
            
            guard context.hasChanges else { return }
            
            do {
                try context.save()
                completion(true)
            } catch {
                completion(false)
            }
        }
    }
}
