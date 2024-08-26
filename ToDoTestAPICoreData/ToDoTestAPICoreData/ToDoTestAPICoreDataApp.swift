//
//  ToDoTestAPICoreDataApp.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI
import CoreData

@main
struct ToDoTestAPICoreDataApp: App {
    let persistenceController = CoreDataManager.shared
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.managedObjectContext, persistenceController.context)
                
                
        }
    }
}
