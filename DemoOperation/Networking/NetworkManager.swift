//
//  NetworkManager.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

class NetworkManager: NetworkingProtocol {
    
    static let shared = NetworkManager()
    var urlSession: URLSession = URLSession.shared
    
    private init() {}
}
