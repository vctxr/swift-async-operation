//
//  FetchGIFDataOperation.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

typealias GIFDataInput = Result<URL, FetchRandomGIFError>

class FetchGIFDataOperation: ChainedAsyncResultOperation<GIFDataInput, Data, FetchRandomGIFError>{
    
    private let networkManager: NetworkingProtocol
    
    init(input: GIFDataInput? = nil, networkManager: NetworkingProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
        super.init(input: input)
    }
    
    override func main() {
        if isFinished { return }
        
        switch input {
        case .success(let url):
            fetchGIFData(with: url)
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
extension FetchGIFDataOperation {
    
    private func fetchGIFData(with url: URL) {
        let request = URLRequest(url: url)
        networkManager.request(with: request, isDecoded: false) { [weak self] (result: Result<Data, RequestError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.finish(with: .success(data))
            case .failure(let error):
                self.finish(with: .failure(.requestError(error)))
            }
        }
    }
}
