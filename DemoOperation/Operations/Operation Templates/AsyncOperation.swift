//
//  AsyncOperation.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

class AsyncOperation: Operation {
    
    enum State: String {
        case ready, executing, finished
        
        fileprivate var key: String {
            "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {   // KVO to manually notify the operation for state changes.
        willSet {
            willChangeValue(forKey: newValue.key)
            willChangeValue(forKey: state.key)
        }
        didSet {
            didChangeValue(forKey: oldValue.key)
            didChangeValue(forKey: state.key)
        }
    }
}

// MARK: - Overrides
extension AsyncOperation {
    
    // The “isReady” attribute needs to incorporate the value from the superclass according to Apple documentation.
    override var isReady: Bool        { super.isReady && state == .ready }
    override var isExecuting: Bool    { state == .executing }
    override var isFinished: Bool     { state == .finished }
    override var isAsynchronous: Bool { true }
    
    override func start() {
        if isCancelled { return state = .finished }
        main()
        state = .executing
    }
    
    override func cancel() {
        state = .finished
    }
}
