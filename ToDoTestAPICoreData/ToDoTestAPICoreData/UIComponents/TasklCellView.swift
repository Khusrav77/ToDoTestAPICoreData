//
//  LocalCellView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI
import CoreData

struct TasklCellView: View {
    var iscompleted: Bool
    var title: String
    var descripsion: String
    var createdAt: String
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if iscompleted {
                Text(title)
                    .strikethrough()
                    .foregroundStyle(Color.tdPrimary.opacity(0.5))
            } else {
                Text(title)
            }
            
            HStack {
                if iscompleted {
                    Text(descripsion)
                        .strikethrough()
                        .foregroundStyle(Color.tdPrimary.opacity(0.5))
                } else {
                    Text(descripsion)
                }
               
                Spacer()
                
                Button {
                    action()
                }label: {
                    Image(systemName: iscompleted ?  "checkmark.circle.fill" : "circle")
                        .foregroundStyle(Color.tdAccent)
                    
                }
            }
            if iscompleted {
                Text(createdAt)
                    .strikethrough()
                    .foregroundStyle(Color.tdPrimary.opacity(0.5))
            } else {
                Text(createdAt)
            }
            
            
        }
        .font(.headline)
        .padding()
        .background(
            iscompleted ? Color.tdPrimary.opacity(0.1) : Color.tdPrimary.opacity(0.25))
        .clipShape(.rect(cornerRadius: 15))
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .padding(.vertical, 6)
        .listStyle(.plain)
    }
}

#Preview {
    
    ZStack{
        BackgroundViewGradient()
        TasklCellView(iscompleted: true, title: "Загрузка списка задач из API", descripsion: "https://dummyjson.com/todos. При первом запуске приложение должно загрузить список задач из указанного json api. ", createdAt: "24.09.12", action: {})
        
            .listStyle(.plain)
            .preferredColorScheme(.dark)
    }
    
}
