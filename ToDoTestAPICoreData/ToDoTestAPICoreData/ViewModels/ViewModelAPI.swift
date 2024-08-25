//
//  ViewModelAPI.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import Foundation
import CoreData

 class ViewModelAPI: ObservableObject {
    
    @Published var todos: [TodoEntity] = []
     
     init() {
         fetchTodosFromCoreData()
     }
    
    func fetchTodosFromAPI() {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching todos: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response String: \(responseString)")
            }
            
            do {
                let todoResponse = try JSONDecoder().decode(TodoResponse.self, from: data)
                DispatchQueue.main.async{
                   
                }
            } catch {
                print("Error decoding todos: \(error)")
            }
        }
        task.resume()
    }
     
     func fetchTodosFromCoreData() {
         let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
         do {
             todos = try CoreDataManager.shared.context.fetch(request)
         } catch  {
             print("Error fetching todos from CoreData: \(error)")
         }
     }
     
     func saveTodosCoreData(todos: [ModelAPI]){
         todos.forEach { todo in
             let entity = TodoEntity(context: CoreDataManager.shared.context)
             entity.id = Int64(todo.id)
             entity.todo = todo.todo
             entity.competed = todo.completed
             entity.userId = Int64(todo.userId)
         }
         
         CoreDataManager.shared.saveContext()
         fetchTodosFromCoreData()
     }
     
     
}
