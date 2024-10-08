//
//  ContentView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        LocalTaskView()
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
        .environmentObject(LocalViewModel())
}
