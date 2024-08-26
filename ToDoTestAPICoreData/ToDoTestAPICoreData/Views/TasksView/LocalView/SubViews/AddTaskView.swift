//
//  AddTaskView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/26/24.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var vm: LocalViewModel
   
    var body: some View {
       
        ZStack {
               // MARK: Background
              BackgroundViewGradient()
               
               VStack (spacing: 25){
                   // MARK: TextField
                   CustomTextField(placeholder: "Enter Your New Task")
                   
                   
                   // MARK: Add Task Button
                   CustomButton(titel: "Add Task") {
                       vm.addTask(title: vm.newTask)
                   }
                   .disabled(vm.newTask.isEmpty)
                   
                   Spacer()
               }
               .padding()
           }
           
           // MARK: - Navigation Bar
           .navigationTitle("Add Task")
           .navigationBarTitleDisplayMode(.inline)
           .navigationBarBackButtonHidden(true)
           .toolbar{
               ToolbarItem(placement: .topBarLeading) {
                   Button {
                       //dismiss()
                   }label: {
                       Image(systemName: "chevron.left")
                           .font(.headline)
                           .foregroundStyle(Color.tdAccent)
                   }
               }
           }
           .onAppear {
               vm.newTask = ""
           }
    }
}

#Preview {
    AddTaskView()
        .preferredColorScheme(.dark)
        .environmentObject(LocalViewModel())
}
