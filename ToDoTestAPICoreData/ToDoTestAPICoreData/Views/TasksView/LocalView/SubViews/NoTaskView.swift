//
//  NoTaskView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 8/26/24.
//

import SwiftUI

struct NoTaskView: View {
    let action: () -> Void
    var body: some View {
        VStack{
            
            Spacer()
            
            // MARK: - Text
            Text("THERE ARE NO TASKS\nWOULD YUO LIKE\n ADD?")
                .font(.title)
                .foregroundStyle(Color.tdPrimary)
                .opacity(0.5)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // MARK: - Button
           
            Button {
                action()
            } label: {
                ZStack{
                    Circle()
                        .frame(width: 100)
                        .foregroundStyle(Color.tdPrimary)
                        .opacity(0.5)
                    
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundStyle(Color.tdBackground2)
                
            }
                
            }
              
            
        }
    }
}
    #Preview {
        NoTaskView(action: {})
            .preferredColorScheme(.dark)
    }
