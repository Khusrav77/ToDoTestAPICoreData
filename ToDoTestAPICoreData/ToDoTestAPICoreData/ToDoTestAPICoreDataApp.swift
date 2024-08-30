//
//  ToDoTestAPICoreDataApp.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI


@main
struct ToDoTestAPICoreDataApp: App {
    @StateObject var vm = LocalViewModel()

    @AppStorage("isDarkMode") private var isDarkMode = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
                .environmentObject(vm)
                
        }
    }
}
