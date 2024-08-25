//
//  ViewModelAPI.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import Foundation
import CoreData

 class ViewModelAPI: ObservableObject {
     
     @Published var tasks: [TodoEntity] = []
     private var coreDataManager = CoreDataManager.shared
     
     
     init() {
         fetchTodosFromCoreData()
     }
    
     
    func fetchTodosFromAPI() {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
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
                    self?.saveTodosCoreData(todos: todoResponse.todos)
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
             tasks = try coreDataManager.context.fetch(request)
         } catch  {
             print("Error fetching todos from CoreData: \(error)")
         }
     }
     
     func deleteTask(at offsets: IndexSet) {
         offsets.forEach { index in
             let task = tasks[index]
             coreDataManager.context.delete(task)
         }
         coreDataManager.saveContext()
         fetchTodosFromCoreData()
     }
     
     func saveTodosCoreData(todos: [ModelAPI]){
         todos.forEach { todo in
             let entity = TodoEntity(context: coreDataManager.context)
             entity.id = Int64(todo.id)
             entity.todo = todo.title
             entity.competed = todo.completed
             entity.userId = Int64(todo.userId)
         }
         
         coreDataManager.saveContext()
         fetchTodosFromCoreData()
     }
     
     
}
