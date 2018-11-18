//
//  CelebrityListViewController.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import UIKit
import CoreData

class CelebrityListViewController: UIViewController {

    @IBOutlet weak var celebrityTableView: UITableView!
    
    private var coreDataManager = CoreDataManager()
    weak var coordinator: MainCoordinator?
    
    lazy var fetchedResultsController: NSFetchedResultsController<SSCelebrity> = {
        let fetchRequest: NSFetchRequest<SSCelebrity> = SSCelebrity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(SSCelebrity.emailId), ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchCelebritiesFromDB()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshDatafromAPI()
    }

    private func setupTableView() {
        celebrityTableView.dataSource = self
        celebrityTableView.estimatedRowHeight = 100
        celebrityTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchCelebritiesFromDB() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("\(error), \(error.localizedDescription)")
        }
    }
    
    private func refreshDatafromAPI() {
        guard let email = LoggedInStateManager.email else { return }
        CelebrityAPI.fetchList.post(with: email) { results in
            switch results {
            case .success(let celebs):
                self.coreDataManager.addToDataBase(celebrities: celebs)
            case .failure(_): break
                // retry
            }
        }
    }
}
