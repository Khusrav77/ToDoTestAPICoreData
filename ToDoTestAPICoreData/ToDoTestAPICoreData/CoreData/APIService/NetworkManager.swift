//
//  NetworkManager.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/29/24.
//

import Foundation


final class NetworkManager {
    
    // MARK: - Properties
    static let shared = NetworkManager()
    
    private let urlTodos = "https://dummyjson.com/todos"
    private let decoder = JSONDecoder()
    
    // MARK: - Initializer
    private init() {}
    
    
    // MARK: - Methods
    func getTasks() async throws ->  TodoResponse {
        guard let url = URL(string: urlTodos) else { throw NetworkError.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        do {
            return try decoder.decode(TodoResponse.self, from: data)
        } catch  {
            throw NetworkError.invalidData
        }
        
    }
}


