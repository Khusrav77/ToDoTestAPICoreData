//
//  CustomTextField.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/26/24.
//

import SwiftUI

struct CustomTextField: View {
    @ObservedObject var vm = LocalViewModel()
    let placeholder: String
    
    var body: some View {
        
        TextField(placeholder, text: $vm.newTask)
                    .font(.headline)
                    .padding()
                    .background(Color.tdPrimary.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
    }
}

#Preview {
    
    CustomTextField(placeholder: "Enter Your New Task")
}
