//
//  AddTaskView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/26/24.
//

import SwiftUI

struct CreateTaskView: View {
    @EnvironmentObject var vm: LocalViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        ZStack {
            
            BackgroundViewGradient()
            
            VStack {
                TextField("Title", text: $vm.title)
                    .font(.headline)
                    .padding()
                    .background(Color.tdPrimary.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                TextField("Descripsion", text: $vm.descripsion)
                    .font(.headline)
                    .padding()
                    .background(Color.tdPrimary.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                DatePicker("Choose a date", selection: $vm.createdAt)
                    .font(.headline)
                    .padding()
                    .background(Color.tdPrimary.opacity(0.15))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                
               
                
                CustomButton(titel: "Add Task") {
                    vm.addNewTask()
                }
                .padding(.top)
            }
            .padding()
            .listStyle(.plain)
        }
        
        // MARK: - Navigation Bar
        .navigationTitle("New Task")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundStyle(Color.tdAccent)
                }
            }
        }
    }
    
}

#Preview {
    
    CreateTaskView()
        .preferredColorScheme(.dark)
        .environmentObject(LocalViewModel())
}
