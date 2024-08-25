//
//  TaskCellView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI

struct TaskCellView: View {
    var model: TodoEntity
    let action: () -> Void
    
    var body: some View {
        HStack {
            if model.competed {
                Text("\(model.todo ?? "Unknown"), id: \(model.userId)")
                    .strikethrough()
                    .foregroundStyle(Color.tdPrimary.opacity(0.5))
            } else {
                Text("\(model.todo ?? "Unknown"), userid: \(model.userId)")
            }
            Spacer()
            
            Button {
                action()
            }label: {
                Image(systemName: model.competed ?  "checkmark.circle.fill" : "circle")
                    .foregroundStyle(Color.tdAccent)
                
            }
           // .buttonStyle(.borederless)
            
        }
        .font(.headline)
        .padding()
        .background(
            model.competed ? Color.tdPrimary.opacity(0.1) : Color.tdPrimary.opacity(0.25))
        .clipShape(.rect(cornerRadius: 15))
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .padding(.vertical, 6)
    }
}

#Preview {
    List {
        
       
    }
    .listStyle(.plain)
    .preferredColorScheme(.dark)
    
}
