//
//  CelebrityAPI.swift
//  Celebs
//
//  Created by Sumit Paul on 18/11/18.
//  Copyright © 2018 Sumit Paul. All rights reserved.
//

import Foundation

enum BaseURL {
    static var components = URLComponents(string: "http://surya-interview.appspot.com/")
}

enum httpMethod: String {
    case post = "POST"
}

enum CelebrityAPI {
    
    case fetchList
    
    var url: URL? {
        switch self {
        case .fetchList:
            var urlcomponents = BaseURL.components
            urlcomponents?.path = "/list"
            return urlcomponents?.url
        }
    }
    
    func post(with email: String, completion: @escaping(ResultType<[Celebrity]>) -> Void) {
        guard let url = CelebrityAPI.fetchList.url else { completion(.failure(error: JSONDecodingError.unknownError)); return }
        var baseUrlRequest = URLRequest(url: url)
        baseUrlRequest.httpMethod = httpMethod.post.rawValue
        let body = Body(emailId: email)
        baseUrlRequest.httpBody = try? JSONEncoder().encode(body)
        
        let dataTask = URLSession.shared.dataTask(with: baseUrlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error: error))
                return
            }
            guard let data = data else { completion(.failure(error: JSONDecodingError.unknownError)); return }
            
            do {
                let celebrities =  try JSONDecoder().decode(Celebrities.self, from: data)
                completion(.success(celebrities.items))
            } catch {
                print(error)
            }
        }
        
        dataTask.resume()
    }
}

enum JSONDecodingError: Error, LocalizedError {
    case unknownError
    
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return NSLocalizedString("Unknown Error occured", comment: "")
        }
    }
}
