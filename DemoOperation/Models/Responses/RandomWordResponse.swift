//
//  RandomWordResponse.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import Foundation

struct RandomWordResponse: Decodable {
    let word: String
    let definition: String
    let pronunciation: String
}
