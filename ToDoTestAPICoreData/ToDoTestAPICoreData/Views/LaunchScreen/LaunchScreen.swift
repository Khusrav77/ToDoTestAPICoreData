//
//  LaunchScreen.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 9/1/24.
//

import SwiftUI

struct LaunchScreen: View {
    
    // MARK: - Properties
    @Binding var isPresented: Bool
    @State private var progress: CGFloat = 0.0
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    
    // MARK: - Body
    var body: some View {
        // MARK: Background
        ZStack {
            BackgroundViewGradient()
            
            // MARK: Logo
            ZStack{
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(Color.tdPrimary.opacity(0.25))
                    .frame(width: 100, height: 100)
                Image(systemName: "checkmark")
                    .font(.largeTitle)
                    .foregroundStyle(Color.tdPrimary)
                
                // MARK: Progress View
                VStack {
                    Spacer()
                    CustomProgressView(initialProgress: $progress, color: Color.tdPrimary)
                        .frame(height: 8)
                        .onReceive([self.progress].publisher) { _ in
                            if self.progress >= 1.0 {
                                self.isPresented = false
                            }
                        }
                        .padding(.bottom, 30)
                        .padding(.horizontal, 40)
                }
                
            }
        }
        .onAppear {
            self.startTime()
        }
        
    }
    
    func startTime() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { time in
            self.progress += 0.05
        }
    }
}

#Preview {
    LaunchScreen(isPresented: .constant(true))
}
