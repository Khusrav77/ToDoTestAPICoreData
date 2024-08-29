//
//  EditTaskView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/28/24.
//

import SwiftUI

struct EditTaskView: View {
    
    // MARK: - Properties
    var task: LocalTaskEntity
    @EnvironmentObject var vm: LocalViewModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        VStack{
            
            // MARK: Nav Bar
            HStack{
                // Title
                Text("Edit Task")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                
                // Cancle Button
                    .overlay(alignment: .topLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .frame(width: 56)
                                .foregroundStyle(Color.tdAccent)
                        }
                    }
                    .padding(.vertical)
            }
            
            // MARK: TextField
            TextField("Title", text: $vm.title)
                .font(.headline)
                .padding()
                .background(Color.tdPrimary.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            TextField("descripsion", text: $vm.descripsion)
                .font(.headline)
                .padding()
                .background(Color.tdPrimary.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            // MARK: Button Save
            CustomButton(titel: "Save") {
                vm.updateTask(id: task.id ?? UUID(), title: task.title ?? "")
            }
            .padding(.top)
            Spacer()
        }
        .padding(.horizontal)
        .background(BackgroundViewGradient())
        .onAppear {
            
        }
    }
}

#Preview {
    EditTaskView(task: LocalTaskEntity())
        .preferredColorScheme(.dark)
        .environmentObject(LocalViewModel())
}
