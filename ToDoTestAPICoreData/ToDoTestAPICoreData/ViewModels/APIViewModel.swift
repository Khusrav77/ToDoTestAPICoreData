//
//  ViewModelAPI.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import Foundation
import CoreData

 class APIViewModel: ObservableObject {
     
     // MARK: - Properties
     @Published var tasks: [APITaskEntity] = []
     private var coreDataManager = CoreDataManager.shared
     
     // MARK: - Initializer
     init() {
         fetchTodosFromCoreData()
     }
    
     // MARK: - Methods
    func fetchTodosFromAPI() async{
        do {
            let tasks = try await NetworkManager.shared.getTasks()
            saveTodosCoreData(tasks: tasks.todos)
            
        } catch  {
            if let error = error as? NetworkError {
                print(error)
            }
        }
    }
       
     
     func fetchTodosFromCoreData() {
         let request: NSFetchRequest<APITaskEntity> = APITaskEntity.fetchRequest()
         do {
             tasks = try coreDataManager.viewContext.fetch(request)
         } catch  {
             print("Error fetching todos from CoreData: \(error)")
         }
     }
     
     // MARK: Save
     func saveTodosCoreData(tasks: [APIModel]) {
            let backgroundContext = coreDataManager.backgroundContext
            
            backgroundContext.perform {
                tasks.forEach { task in
                    let entity = APITaskEntity(context: backgroundContext)
                    entity.id = Int32(task.id)
                    entity.todo = task.title
                    entity.completed = task.completed
                    entity.userId = Int32(task.userId)
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
}
