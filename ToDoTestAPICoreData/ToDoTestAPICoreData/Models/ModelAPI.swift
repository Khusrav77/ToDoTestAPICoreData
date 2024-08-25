//
//  ModelAPI.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import Foundation

struct ModelAPI: Codable, Identifiable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

struct TodoResponse: Codable {
    let todos: [ModelAPI]
    let total: Int
    let skip: Int
    let limit: Int
}
