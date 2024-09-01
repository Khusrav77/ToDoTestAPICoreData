//
//  APICellView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/28/24.
//

import SwiftUI

struct APICellView: View {
    
    // MARK: - Properties
    var task: APITaskEntity
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if task.completed {
                Text("id: \(task.id)")
                    .strikethrough()
                    .foregroundStyle(Color.tdPrimary.opacity(0.5))
                Divider()
            } else {
                Text("id: \(task.id)")
                Divider()
                    .background(.white)
            }
            
            HStack {
                if task.completed {
                    Text(task.todo ?? "")
                        .strikethrough()
                        .foregroundStyle(Color.tdPrimary.opacity(0.5))
                } else {
                    Text(task.todo ?? "")
                        .foregroundStyle(Color.tdPrimary.opacity(0.8))
                }
               
                Spacer()
                
                Button {
                    
                }label: {
                    Image(systemName: task.completed ?  "checkmark.circle.fill" : "circle")
                        .foregroundStyle(Color.tdAccent)
                    
                }
            }
            
            HStack {
               
                if task.completed {
                    Text("userId: \(task.userId)")
                        .strikethrough()
                        .foregroundStyle(Color.tdPrimary.opacity(0.5))
                } else {
                    Text("userId: \(task.userId)")
                        .foregroundStyle(Color.tdPrimary.opacity(0.6))
                }
            
            }
            
            
        }
        .font(.headline)
        .padding()
        .background(
            task.completed ? Color.tdPrimary.opacity(0.1) : Color.tdPrimary.opacity(0.25))
        .clipShape(.rect(cornerRadius: 15))
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .padding(.vertical, 6)
        .listStyle(.plain)
    }
}

#Preview {
    APITaskView()
        .preferredColorScheme(.dark)
}
