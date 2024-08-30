//
//  LocalViewModel.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import Foundation
import CoreData

class LocalViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var isselectedTask: LocalTaskEntity?
    @Published var tasks: [LocalTaskEntity] = []
   
    @Published var iscompleted: Bool = false
    @Published var title: String = ""
    @Published var descripsion: String = ""
    @Published var createdAt: Date = Date()
   
    
    private var coreDataManager = CoreDataManager.shared
    
    // Progress View Property
       var completionProgress: Double {
           let totalTask = tasks.count
           let comletionTasks = tasks.filter {$0.iscompleted}.count
           return totalTask > 0 ? Double(comletionTasks) / Double(totalTask) : 0
       }
    
    // MARK: - Initializer
    init() {
        fetchTasks()
    }
    
    // MARK: - Methods
    func fetchTasks () {
        let request: NSFetchRequest<LocalTaskEntity> = LocalTaskEntity.fetchRequest()
        do {
            tasks = try coreDataManager.viewContext.fetch(request)
        } catch {
            print("Error fetching todos from CoreData: \(error)")
        }
    }

    
    // MARK:  Create
    func addNewTask() {
            let newTask = LocalTaskEntity(context: coreDataManager.viewContext)
            newTask.id = UUID()
            newTask.title = title
            newTask.descripsion = descripsion
            newTask.iscompleted = iscompleted
            newTask.createdAt = createdAt
        
        tasks.append(newTask)
        saveContext()
        
    }
    
    // MARK: Save
    func saveContext() {
            do {
                try coreDataManager.viewContext.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
     
    // MARK: Update
    func updateTask(id: UUID, title: String) {
            if let index = tasks.firstIndex(where: { $0.id == id }) {
                tasks[index].title = title
                saveContext()
            }
        }
    
    // MARK:  Delete
    func deleteTask(at offsets: IndexSet) {
            offsets.forEach { index in
                let task = tasks[index]
                coreDataManager.viewContext.delete(task)
            }
            tasks.remove(atOffsets: offsets)
            saveContext()
        }
    
    func isCompetedTask(task: LocalTaskEntity ) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].iscompleted.toggle()
            saveContext()
            fetchTasks()
        }
    }
    
}





