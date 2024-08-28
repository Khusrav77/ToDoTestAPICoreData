//
//  ViewModelAPI.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import Foundation
import CoreData

 class APIViewModel: ObservableObject {
     
     @Published var tasks: [APITaskEntity] = []
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
         let request: NSFetchRequest<APITaskEntity> = APITaskEntity.fetchRequest()
         do {
             tasks = try coreDataManager.viewContext.fetch(request)
         } catch  {
             print("Error fetching todos from CoreData: \(error)")
         }
     }
     
     func saveTodosCoreData(tasks: [APIModel]) {
            let backgroundContext = coreDataManager.backgroundContext
            
            backgroundContext.perform {
                tasks.forEach { task in
                    let entity = APITaskEntity(context: backgroundContext)
                    entity.id = Int64(task.id)
                    entity.todo = task.title
                    entity.completed = task.completed
                    entity.userId = Int64(task.userId)
                }
            
                do {
                    try backgroundContext.save()
                    DispatchQueue.main.async {
                        self.fetchTodosFromCoreData()
                    }
                } catch {
                    print("Error saving todos to CoreData: \(error)")
                }
            }
        }
        
        func deleteTask(at offsets: IndexSet) {
            let backgroundContext = coreDataManager.backgroundContext
            
            backgroundContext.perform {
                offsets.forEach { index in
                    let task = self.tasks[index]
                    if let objectId = task.objectID as? NSManagedObjectID {
                        let objectToDelete = backgroundContext.object(with: objectId)
                        backgroundContext.delete(objectToDelete)
                    }
                }
                
                do {
                    try backgroundContext.save()
                    DispatchQueue.main.async {
                        self.fetchTodosFromCoreData()
                    }
                } catch {
                    print("Error deleting todos from CoreData: \(error)")
                }
            }
        }
     
//     func saveTodosCoreData(tasks: [APIModel]){
//         tasks.forEach { task in
//             let entity = APITaskEntity(context: coreDataManager.viewContext)
//             entity.id = Int64(task.id)
//             entity.todo = task.title
//             entity.completed = task.completed
//             entity.userId = Int64(task.userId)
//         }
//         
//         coreDataManager.saveContext()
//         fetchTodosFromCoreData()
//     }
//     
//     func deleteTask(at offsets: IndexSet) {
//         offsets.forEach { index in
//             let task = tasks[index]
//             coreDataManager.viewContext.delete(task)
//         }
//         coreDataManager.saveContext()
//         fetchTodosFromCoreData()
//     }
     
     
}
