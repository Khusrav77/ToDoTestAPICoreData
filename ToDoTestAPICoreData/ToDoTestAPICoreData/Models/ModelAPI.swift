//
//  ModelAPI.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import Foundation



struct ModelAPI: Decodable, Identifiable {
    let id: Int
    let title: String
    let completed: Bool
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
          case id
          case title = "todo"
          case completed
          case userId
      }
}

struct TodoResponse: Decodable {
    let todos: [ModelAPI]
    let total: Int
    let skip: Int
    let limit: Int
}
