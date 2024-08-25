//
//  LocalViewModel.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import Foundation
import CoreData

class LocalViewModel: ObservableObject {
    @Published var tasks: [LocalTaskEntity] = []
    @Published var newTask = ""
    private var coreDataManager = CoreDataManager.shared
    
    init() {
        fetchTaskItemFromCoreData()
    }
    
    func fetchTaskItemFromCoreData () {
        let request: NSFetchRequest<LocalTaskEntity> = LocalTaskEntity.fetchRequest()
        do {
            tasks = try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching todos from CoreData: \(error)")
        }
    }
    
    func isCompetedTask(task: LocalTaskEntity) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].iscompleted.toggle()
            saveContext()
        }
    }

    
    // MARK:  Create
    func addTask(title: String) {
            let newTask = LocalTaskEntity(context: coreDataManager.context)
            newTask.id = UUID()
            newTask.title = title
            newTask.iscompleted = false
            newTask.createdAt = Date()
            
            tasks.append(newTask)
            saveContext()
        }
    
    // MARK: Save
    func saveContext() {
            do {
                try coreDataManager.context.save()
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
                coreDataManager.context.delete(task)
            }
            tasks.remove(atOffsets: offsets)
            saveContext()
        }
}





