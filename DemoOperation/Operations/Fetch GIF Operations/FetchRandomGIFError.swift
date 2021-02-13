//
//  FetchRandomGIFError.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 13/02/21.
//

import Foundation

enum ChainedAsyncResultOperationError: Error {
    case noInput
    case canceled
}

enum FetchRandomGIFError: Error {
    case requestError(_ error: RequestError)
    case operationError(_ error: ChainedAsyncResultOperationError)
    case noWord
    case noURL
    case noData
    case canceled
}
