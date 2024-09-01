//
//  ContainerView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 9/1/24.
//

import SwiftUI

struct ContainerView: View {
    // MARK: - Properties
        @State private var isLaunchScreanViewPewsented = true
        
        // MARK: - Body
    var body: some View {
        if !isLaunchScreanViewPewsented {
                   ContentView()
               } else {
                   LaunchScreen(isPresented: $isLaunchScreanViewPewsented)
               }
    }
}

#Preview {
    ContainerView()
        .preferredColorScheme(.dark)
        .environmentObject(LocalViewModel())
}
