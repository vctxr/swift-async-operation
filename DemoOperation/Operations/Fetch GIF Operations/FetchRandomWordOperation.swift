//
//  FetchRandomWordOperation.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

class FetchRandomWordOperation: ChainedAsyncResultOperation<String, String, FetchRandomGIFError> {
    
    private let networkManager: NetworkingProtocol
    
    init(input: String? = nil, networkManager: NetworkingProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
        super.init(input: input)
    }
    
    override func main() {
        if isFinished { return }
        fetchRandomWord()
    }
    
    override func cancel() {
        networkManager.cancel()
        cancel(with: .operationError(.canceled))
    }
}

// MARK: - Private Implementation
extension FetchRandomWordOperation {
    
    private func fetchRandomWord() {
        let urlRequest = RandomWordEndpoint.word.urlRequest
        networkManager.request(with: urlRequest) { [weak self] (result: Result<[RandomWordResponse], RequestError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                guard let word = response.first?.word, !word.isEmpty else {
                    return self.finish(with: .failure(.noWord))
                }
                self.finish(with: .success(word))
            case .failure(let error):
                self.finish(with: .failure(.requestError(error)))
            }
        }
    }
}
