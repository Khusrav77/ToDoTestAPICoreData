//
//  MainView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm = ViewModelAPI()
   
    var body: some View {
        NavigationView {
            List(vm.tasks, id: \.id) { task in
                VStack {
                    Text(task.todo ?? "Unknown")
                        .font(.headline)
                    
                    Text("Compledet: \(task.competed ? "yes" : "No")")
                }
            }
            .navigationTitle("Todos")
            .onAppear {
                if vm.tasks.isEmpty {
                    vm.fetchTodosFromAPI()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
