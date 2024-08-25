//
//  BackgroundViewGradient.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/25/24.
//

import SwiftUI

struct BackgroundViewGradient: View {
    var body: some View {
        LinearGradient(colors:
                        [Color.tdBackground1, Color.tdBackground2],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundViewGradient()
}
