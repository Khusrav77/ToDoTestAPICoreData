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
                            .onAppear {
                                vm.fetchTodosFromAPI()
                            }
                    } else {
                        List {
                            ForEach(vm.tasks, id: \.id) { task in
                                TasklCellView(iscompleted: task.completed, title: ("userId: \(task.userId)"), descripsion: task.todo ?? "", createdAt: "") {
                                    
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Todos")
        }
    }
}

#Preview {
    APITaskView()
        .preferredColorScheme(.dark)
    
}
