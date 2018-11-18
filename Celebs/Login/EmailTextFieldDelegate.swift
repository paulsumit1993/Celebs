//
//  EmailTextFieldDelegate.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import UIKit

/// <#Description#>
class EmailTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    private var errorLabel: UILabel
    
    init(label: UILabel) {
        self.errorLabel = label
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let email = textField.text else { return }
        validateEmail(email)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let email = textField.text else { return true }
        validateEmail(email)
        return true
    }
    
    private func validateEmail(_ email: String) {
        do {
            try EmailValidator.validate(email)
            errorLabel.isHidden = true
        } catch let err as EmailValidationError {
            errorLabel.isHidden = false
            errorLabel.text = err.localizedDescription
        } catch {
            // handle generic error
        }
    }
}
