//
//  LocalCellView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI
import CoreData

struct TasklCellView: View {
    
    // MARK: - Properties
    var task: LocalTaskEntity
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if task.iscompleted {
                Text(task.title ?? "")
                    .font(.headline)
                    .strikethrough()
                    .foregroundStyle(Color.tdPrimary.opacity(0.5))
                Divider()
            } else {
                Text(task.title ?? "")
                    .font(.headline)
                    .foregroundStyle(Color.tdPrimary)
                    
            }
            
            HStack {
                if task.iscompleted {
                    Text(task.descripsion ?? "")
                        .font(.subheadline)
                        .strikethrough()
                        .foregroundStyle(Color.tdPrimary.opacity(0.5))
                } else {
                    Text(task.descripsion ?? "")
                        .font(.subheadline)
                        .foregroundStyle(Color.tdPrimary)
                }
               
                Spacer()
                
                Button {
                    action()
                }label: {
                    Image(systemName: task.iscompleted ?  "checkmark.circle.fill" : "circle")
                        .foregroundStyle(Color.tdAccent)
                    
                }
                .buttonStyle(.borderless)
            }
            
            HStack {
               
                if task.iscompleted {
                    Text(formatDate(task.createdAt ?? Date()))
                        .font(.subheadline)
                        .strikethrough()
                        .foregroundStyle(Color.tdPrimary.opacity(0.5))
                } else {
                    Text(formatDate(task.createdAt ?? Date()))
                        .font(.subheadline)
                        .foregroundStyle(Color.tdPrimary.opacity(0.8))
    
                }
            
            }
            
        }
        .font(.headline)
        .padding()
        .background(
            task.iscompleted ? Color.tdPrimary.opacity(0.1) : Color.tdPrimary.opacity(0.25))
        .clipShape(.rect(cornerRadius: 15))
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .padding(.vertical, 6)
        .listStyle(.plain)
    }
    
    // MARK: - Mthode
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.string(from: date)
    }
}



#Preview {

    ZStack{
       LocalTaskView()
        
            .listStyle(.plain)
            .preferredColorScheme(.dark)
            .environmentObject(LocalViewModel())
    }
    
}
