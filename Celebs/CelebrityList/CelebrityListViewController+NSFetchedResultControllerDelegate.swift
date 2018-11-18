//
//  CelebrityListViewController+NSFetchedResultControllerDelegate.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import UIKit
import CoreData

extension CelebrityListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        celebrityTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        celebrityTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            
            if let indexpath = newIndexPath {
                celebrityTableView.insertRows(at: [indexpath], with: .automatic)
            }
            
        case .delete:
            
            if let indexpath = indexPath {
                celebrityTableView.deleteRows(at: [indexpath], with: .automatic)
            }
            
        case .update:
            
            if let indexpath = indexPath, let cell = celebrityTableView.cellForRow(at: indexpath) as? CelebrityListTableViewCell {
                cell.configure(with: fetchedResultsController.object(at: indexpath))
            }
            
        case .move:
            
            if let indexpath = indexPath {
                celebrityTableView.deleteRows(at: [indexpath], with: .automatic)
            }
            
            if let newIndexpath = newIndexPath {
                celebrityTableView.insertRows(at: [newIndexpath], with: .automatic)
            }
        }
    }
}
