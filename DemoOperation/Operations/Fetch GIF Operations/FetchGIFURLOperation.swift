//
//  FetchGIFURLOperation.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

typealias GIFURLInput = Result<String, FetchRandomGIFError>

class FetchGIFURLOperation: ChainedAsyncResultOperation<GIFURLInput, URL, FetchRandomGIFError> {
    
    private let networkManager: NetworkingProtocol
    
    init(input: GIFURLInput? = nil, networkManager: NetworkingProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
        super.init(input: input)
    }
    
    override func main() {
        if isFinished { return }
        
        switch input {
        case .success(let randomWord):
            fetchGIFURL(for: randomWord)
        case .failure(let error):
            finish(with: .failure(error))
        default:
            finish(with: .failure(.operationError(.noInput)))
        }
    }
    
    override func cancel() {
        networkManager.cancel()
        cancel(with: .operationError(.canceled))
    }
}

// MARK: - Private Implementation
extension FetchGIFURLOperation {
    
    private func fetchGIFURL(for query: String) {
        let urlRequest = GiphyEndpoint.searchGIFs(query: query).urlRequest
        networkManager.request(with: urlRequest) { [weak self] (result: Result<GiphyResponse, RequestError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                guard let gifUrlString = response.data.first?.urlString,
                      let gifUrl = URL(string: gifUrlString) else {
                    return self.finish(with: .failure(.noURL))
                }
                self.finish(with: .success(gifUrl))
            case .failure(let error):
                self.finish(with: .failure(.requestError(error)))
            }
        }
    }
}
