//
//  RandomWordEndpoint.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

enum RandomWordEndpoint: Endpoint {
    case word
}

extension RandomWordEndpoint {
    
    var baseUrl: String {
        return "https://random-words-api.vercel.app"
    }
    
    var path: String {
        switch self {
        case .word:
            return "/word"
        }
    }
    
    var urlParameters: [URLQueryItem] {
        return []
    }
}
