//
//  ViewModelAPI.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import Foundation
import CoreData

 class APIViewModel: ObservableObject {
     
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
                    self?.saveTodosCoreData(tasks: todoResponse.todos)
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
     
     
     func saveTodosCoreData(tasks: [APIModel]){
         tasks.forEach { task in
             let entity = TodoEntity(context: coreDataManager.context)
             entity.id = Int64(task.id)
             entity.todo = task.title
             entity.competed = task.completed
             entity.userId = Int64(task.userId)
         }
         
         coreDataManager.saveContext()
         fetchTodosFromCoreData()
     }
     
     func deleteTask(at offsets: IndexSet) {
         offsets.forEach { index in
             let task = tasks[index]
             coreDataManager.context.delete(task)
         }
         coreDataManager.saveContext()
         fetchTodosFromCoreData()
     }
     
     
}
