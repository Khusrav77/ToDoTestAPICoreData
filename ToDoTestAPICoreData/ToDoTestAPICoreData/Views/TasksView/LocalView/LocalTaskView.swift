//
//  LocalTaskView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI

struct LocalTaskView: View {
    @EnvironmentObject var vm: LocalViewModel
    var body: some View {
        
        ZStack {
            BackgroundViewGradient()
            VStack{
                if vm.tasks .isEmpty {
                    
                    
                } else {
                    
                    List{
                        ForEach(vm.tasks, id: \.id ) { task in
                            TasklCellView(
                                iscompleted: task.iscompleted,
                                title: task.title ?? "",
                                descripsion: task.description,
                                createdAt: ("\(String(describing: task.createdAt))")) {
                                    
                                }
                            
                        }
                    }
                }
                
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    LocalTaskView()
        .preferredColorScheme(.dark)
        .environmentObject(LocalViewModel())
    
}
