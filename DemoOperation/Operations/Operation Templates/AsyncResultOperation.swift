//
//  Operation.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

class AsyncResultOperation<Success, Failure>: AsyncOperation where Failure: Error {
    
    private(set) var result: Result<Success, Failure>? {
        didSet {
            guard let result = result else { return }
            DispatchQueue.main.async {
                self.onResult?(result)
            }
        }
    }
    
    var onResult: ((_ result: Result<Success, Failure>) -> Void)?
    var onStart: (() -> Void)?
    
    override func start() {
        DispatchQueue.main.async {
            self.onStart?()
        }
        super.start()
    }
    
    func finish(with result: Result<Success, Failure>) {
        self.result = result
        state = .finished
    }
    
    func cancel(with error: Failure) {
        result = .failure(error)
        super.cancel()
    }
    
    override func cancel() {
        fatalError("You should use cancel(with: ) to ensure a result")
    }
}
