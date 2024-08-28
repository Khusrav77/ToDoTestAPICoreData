//
//  LocalTaskView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI

struct LocalTaskView: View {
    @State private var showAPI = false
    @State private var showCreate = false
    @State private var isEditViewPresented = false
    @EnvironmentObject var vm: LocalViewModel
    
    var body: some View {
        NavigationStack{
            ZStack {
                BackgroundViewGradient()
                VStack{
                    if vm.tasks .isEmpty {
                        
                        NoTaskView {
                            showCreate.toggle()
                        }
                        
                    } else {
                        
                        List{
                            ForEach(vm.tasks, id: \.id ) { task in
                                TasklCellView(
                                    iscompleted: task.iscompleted,
                                    title: task.title ?? "",
                                    descripsion: task.descripsion ?? "",
                                    createdAt: formatDate(task.createdAt ?? Date())) {
                                        vm.isCompetedTask(task: task)
                                    }
                                    .onTapGesture {
                                        vm.isselectedTask = task
                                        isEditViewPresented.toggle()
                                    }
                                }
                                .onDelete(perform: vm.deleteTask(at:))
                            
                                .sheet(isPresented: $isEditViewPresented, content: {
                                    if let taskToEdit = vm.isselectedTask {
                                        EditTaskView(task: taskToEdit)
                                    }
                                })
                        
                            }
                        }
                    
                    }
                   .listStyle(.plain)
                    
                }
            .navigationTitle("LocalTasks")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showAPI.toggle()
                    }label: {
                        Label("FethAPI", systemImage: "network")
                    }
                }
            
            
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showCreate.toggle()
                    }label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showCreate,  content: {
                NavigationStack {
                    CreateTaskView()
                }
                .presentationDetents([.medium])
            })
            
            .sheet(isPresented: $showAPI,  content: {
                NavigationStack {
                    APITaskView()
                }
                .presentationDetents([])
            })
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
}


#Preview {
    NavigationStack{
        LocalTaskView()
            .preferredColorScheme(.dark)
            .environmentObject(LocalViewModel())
    }
   
    
}
