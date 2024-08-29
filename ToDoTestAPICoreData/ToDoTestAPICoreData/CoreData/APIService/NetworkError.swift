//
//  NetworkError.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/29/24.
//

import Foundation


enum NetworkError: String, Error {
    case invalidURL = "Invalid URL"
    case invalidResponse = "Invalid response from the server"
    case invalidData = "The data received from the server is invalid"
}
