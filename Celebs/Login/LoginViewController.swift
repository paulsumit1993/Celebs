//
//  ViewController.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidationErrorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            signInButton.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var loginActivityIndicatorView: UIActivityIndicatorView!
    
    private var emailTextFieldDelegate: EmailTextFieldDelegate?
    weak var coordinator: MainCoordinator?
    private var coreDataManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    @IBAction func signInUser(_ sender: UIButton) {
        guard emailValidationErrorLabel.isHidden == true,
            let email = emailTextField.text else { return }
        loginActivityIndicatorView.startAnimating()
        CelebrityAPI.fetchList.post(with: email) { [weak self] result in
            switch result {
            case .success(let celebs):
                LoggedInStateManager.set(loggedIn: true)
                LoggedInStateManager.set(email: email)
                self?.coreDataManager.addToDataBase(celebrities: celebs)
                self?.coordinator?.openCelebrityScreen(with: self?.loginActivityIndicatorView)
            case .failure(let e):
                DispatchQueue.main.async {
                    self?.loginActivityIndicatorView.stopAnimating()
                    self?.showError(e.localizedDescription)
                }
            }
        }
    }
    
    private func setupTextField() {
        emailTextFieldDelegate = EmailTextFieldDelegate(label: emailValidationErrorLabel)
        emailTextField.delegate = emailTextFieldDelegate
    }
    
}


