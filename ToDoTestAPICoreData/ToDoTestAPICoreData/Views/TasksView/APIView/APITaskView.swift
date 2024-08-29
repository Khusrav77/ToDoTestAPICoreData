//
//  MainView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI

struct APITaskView: View {
    @ObservedObject var vm = APIViewModel()
    
    var body: some View {
        NavigationView {
            
            ZStack {
                BackgroundViewGradient()
                
                VStack {
                    if vm.tasks.isEmpty {
                        ProgressView("Loading Todos...")
                            .task {
                               await vm.fetchTodosFromAPI()
                            }
                    } else {
                        List {
                            ForEach(vm.tasks, id: \.id) { task in
                                APICellView(task: task)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("APITodos")
        }
    }
}

#Preview {
    APITaskView()
        .preferredColorScheme(.dark)
    
}
