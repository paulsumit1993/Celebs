//
//  CelebrityListViewController.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import UIKit

class CelebrityListViewController: UIViewController {

    @IBOutlet weak var celebrityTableView: UITableView!
    
    private var coreDataManager = CoreDataManager()
    weak var coordinator: MainCoordinator?
    lazy var fetchedResultsController = coreDataManager.fetchedResultsController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshDatafromAPI()
    }

    private func setupTableView() {
        fetchedResultsController.delegate = self
        celebrityTableView.dataSource = self
        celebrityTableView.estimatedRowHeight = 100
        celebrityTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func fetchCelebritiesFromDB() {
        do {
            try fetchedResultsController.performFetch()
            celebrityTableView.reloadData()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    private func refreshDatafromAPI() {
        guard let email = LoggedInStateManager.email else { return }
        CelebrityAPI.fetchList.post(with: email) { [weak self] results in
            switch results {
            case .success(let celebs):
                self?.coreDataManager.addToDataBase(celebrities: celebs) { _ in
                    self?.fetchCelebritiesFromDB()
                }
            case .failure(_):
                self?.fetchCelebritiesFromDB()
            }
        }
    }
}
