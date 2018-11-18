//
//  Celebrity.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import Foundation

struct Celebrities: Decodable {
    let items: [Celebrity]
}

struct Celebrity: Decodable {
    let emailId: String
    let imageUrl: URL
    let firstName: String
    let lastName: String
    var fullName: String {
        var personNameComponents = PersonNameComponents()
        personNameComponents.givenName = firstName
        personNameComponents.familyName = lastName
        return PersonNameComponentsFormatter.localizedString(from: personNameComponents,
                                                             style: .medium,
                                                             options: [])
    }
    
}
