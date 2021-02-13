//
//  RandomGIFVM.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

class RandomGIFVM {
    
    let isLoading: BoxListener<Bool>        = BoxListener(false)
    let loadingMessage: BoxListener<String> = BoxListener("")
    let randomWord: BoxListener<String>     = BoxListener("")
    let gifData: BoxListener<Data?>         = BoxListener(nil)
    let isNeedResetGIF: BoxListener<Bool>   = BoxListener(false)
    
    private var attempts: Int = 1
    private var findingAvailableGIFsMessage = "Finding available GIFs ..."
    private var matchingGIFFoundMessage     = "Matching GIF Found! \nLoading ..."
    private var gifNotFoundMessage          = "No matching GIF found"

    private let networkManager: NetworkingProtocol
    private let queue = OperationQueue()
    
    init(networkManager: NetworkingProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchRandomGIF(attempt: Int = 1) {
        attempts = attempt
        queue.cancelAllOperations()
        
        let operations = configuredOperations()
        queue.addOperations(operations, waitUntilFinished: false)
    }
    
    func cancel() {
        attempts = 3
        queue.cancelAllOperations()
    }
}

// MARK: - Private Implementation
extension RandomGIFVM {
    
    private func configuredOperations() -> [Operation] {
        let fetchRandomWord = FetchRandomWordOperation(networkManager: networkManager)
        let fetchGIFURL     = FetchGIFURLOperation(networkManager: networkManager)
        let fetchGIFData    = FetchGIFDataOperation(networkManager: networkManager)
        
        fetchGIFURL.addDependency(fetchRandomWord)
        fetchGIFData.addDependency(fetchGIFURL)
        
        fetchRandomWord.onStart = { [weak self] in
            guard let self = self else { return }
            self.isNeedResetGIF.value = true
            self.randomWord.value = ""
            self.loadingMessage.value = self.findingAvailableGIFsMessage
            self.isLoading.value = true
        }
        
        fetchRandomWord.onResult = { [weak self] result in
            guard let self = self else { return }
            if case .success(let randomWord) = result {
                self.randomWord.value = randomWord
            }
        }
        
        fetchGIFURL.onResult = { [weak self] result in
            guard let self = self else { return }
            if case .success = result {
                self.loadingMessage.value = self.matchingGIFFoundMessage
            }
        }
        
        fetchGIFData.onResult = { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            
            switch result {
            case .success(let gifData):
                self.gifData.value = gifData
            case .failure(let error):
                print("Failed to get random gif: \(error), attempt: \(self.attempts)")
                self.retryFetchIfNeeded(attempts: self.attempts)
            }
        }
        
        return [fetchRandomWord, fetchGIFURL, fetchGIFData]
    }
    
    private func retryFetchIfNeeded(attempts: Int) {
        if attempts == 3 {
            gifData.value = nil
            randomWord.value = gifNotFoundMessage
        } else {
            fetchRandomGIF(attempt: attempts + 1)
        }
    }
}
