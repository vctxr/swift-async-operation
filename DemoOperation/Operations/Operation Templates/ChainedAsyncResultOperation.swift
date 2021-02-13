//
//  ChainedAsyncResultOperation.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

protocol ChainedAsyncResultOutputProviding {
    var outputResult: Any? { get }
}

class ChainedAsyncResultOperation<Input, Output, Failure>: AsyncResultOperation<Output, Failure> where Failure: Error {
    
    private(set) var input: Input?
    
    private var inputFromDependencies: Input? {
        dependencies.compactMap { $0 as? ChainedAsyncResultOutputProviding }.first?.outputResult as? Input
    }
    
    init(input: Input? = nil) {
        self.input = input
        super.init()
    }
    
    override func start() {
        input = input ?? inputFromDependencies
        super.start()
    }
}

// MARK: - ChainedAsyncResultOutputProviding
extension ChainedAsyncResultOperation: ChainedAsyncResultOutputProviding {
    var outputResult: Any? { result }
}
