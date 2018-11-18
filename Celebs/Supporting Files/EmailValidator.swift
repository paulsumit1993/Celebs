//
//  EmailValidator.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import Foundation


enum EmailValidationError: Error, LocalizedError {
    case emailInvalid
    
    var localizedDescription: String {
        switch self {
        case .emailInvalid:
            return "E-mail entered is invalid"
        }
    }
}

struct EmailValidator {
    
    private init() {}
    
    /// Validates any email-id
    ///
    /// - Parameter email: Email to be validated
    /// - Throws: EmailValidationError
    static func validate(_ email: String) throws {
        var succeeded = false
        guard email.count > 0 else { throw EmailValidationError.emailInvalid }
        let emailRegex = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        succeeded = predicate.evaluate(with: email)
        guard succeeded == true else { throw EmailValidationError.emailInvalid }
    }
}
