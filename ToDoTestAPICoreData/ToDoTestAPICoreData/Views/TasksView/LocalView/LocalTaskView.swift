//
//  LocalTaskView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI

struct LocalTaskView: View {
    // MARK: - Properties
    @State private var showAPI = false
    @State private var showCreate = false
    @State private var isEditViewPresented = false
    @EnvironmentObject var vm: LocalViewModel
    
    // MARK: - Body
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
                                TasklCellView(task: task) {
                                    vm.isCompetedTask(task: task)
                                }
                                .onTapGesture {
                                    vm.isselectedTask = task
                                    isEditViewPresented = true
                                }
                            }
                            .onDelete(perform: vm.deleteTask(at:))
                            .sheet(isPresented: $isEditViewPresented) {
                                if let taskToEdit = vm.isselectedTask {
                                    EditTaskView(task:taskToEdit)
                                }
                            }
                        }
                        
                    }
                    
                }
                .listStyle(.plain)
            }
            
            // MARK: - Navigation Bar
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
}


#Preview {
    NavigationStack{
        LocalTaskView()
            .preferredColorScheme(.dark)
            .environmentObject(LocalViewModel())
    }
    
    
}
