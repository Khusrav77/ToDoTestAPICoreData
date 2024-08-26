//
//  CustomButton.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/26/24.
//

import SwiftUI

struct CustomButton: View {
    
    @Environment (\.dismiss) private var dismiss
    let titel: String
    let action: () -> ()
    
    
    var body: some View {
        Button {
            action()
            dismiss()
        } label: {
            Text(titel)
                .font(.headline)
                .padding()
                .foregroundStyle(Color.tdBackground1)
                .frame(maxWidth: .infinity)
                .background(Color.tdAccent)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

#Preview {
    CustomButton(titel: "Add Task", action: {})
}
