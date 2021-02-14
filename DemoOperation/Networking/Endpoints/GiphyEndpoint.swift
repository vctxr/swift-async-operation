//
//  GiphyEndpoint.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

enum GiphyEndpoint: Endpoint {
    case searchGIFs(query: String)
}

extension GiphyEndpoint {
    
    var baseUrl: String {
        return "https://api.giphy.com"
    }
    
    var path: String {
        switch self {
        case .searchGIFs:
            return "/v1/gifs/search"
        }
    }
    
    var urlParameters: [URLQueryItem] {
        guard let data = KeyChain.load(key: .apiKey) else { return [] }
        let apiKey = String(decoding: data, as: UTF8.self)
        var urlQueryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        switch self {
        case .searchGIFs(query: let query):
            urlQueryItems.append(URLQueryItem(name: "q", value: query))
            return urlQueryItems
        }
    }
}
