//
//  MainView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject  var vm: ViewModelAPI
   
    var body: some View {
        NavigationView {
            
            ZStack {
               BackgroundViewGradient()
               
                List {
                    ForEach(vm.tasks, id: \.id) { task in
                        TaskCellView(model: task) {
                            
                        }
                    }
                }
                
                }
                .onAppear {
                    if vm.tasks.isEmpty {
                        vm.fetchTodosFromAPI()
                    }
            
            }
            .navigationTitle("Todos")
        }
    }
}

#Preview {
    MainView()
        .preferredColorScheme(.dark)
        .environmentObject(ViewModelAPI())
}
