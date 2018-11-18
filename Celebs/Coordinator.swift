//
//  Coordinator.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if LoggedInStateManager.isLoggedIn {
            openCelebrityScreen(with: nil)
        } else {
            openLoginScreen()
        }
    }
    
    func openLoginScreen() {
        let vc = R.storyboard.main.loginViewController()!
        vc.coordinator = self
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.navigationBar.isHidden = true
            self?.navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func openCelebrityScreen(with activityIndicator: UIActivityIndicatorView?) {
        let vc = R.storyboard.main.celebrityListViewController()!
        vc.coordinator = self
        DispatchQueue.main.async { [weak self] in
            self?.navigationController.navigationBar.isHidden = true
            activityIndicator?.stopAnimating()
            self?.navigationController.pushViewController(vc, animated: true)
        }
    }
}