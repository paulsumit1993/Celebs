//
//  CelebrityListViewController+UITableViewDelegate.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import UIKit

extension CelebrityListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let celebrities = fetchedResultsController.sections?[section] else { return 0 }
        return celebrities.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.celebrityListTableViewCell, for: indexPath) else { fatalError() }
        cell.configure(with: fetchedResultsController.object(at: indexPath))
        return cell
    }
}
