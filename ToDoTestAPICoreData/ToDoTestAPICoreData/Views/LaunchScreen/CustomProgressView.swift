//
//  CustomProgreesView.swift
//  ToDoTestAPICoreData
//
//  Created by Khusrav Safiev on 9/1/24.
//

import SwiftUI

struct CustomProgressView: View {
    // MARK: - Properties
    @Binding var progress: CGFloat
    private var barColor: Color
    private var animationTime: TimeInterval = 0.3
    
    // MARK: - Initilazer
    public init(initialProgress: Binding<CGFloat>, color: Color) {
        self._progress = initialProgress
        self.barColor = color
    }
    var body: some View {
        GeometryReader {geo in
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(barColor.opacity(0.3))
                
                Rectangle()
                    .fill(barColor)
                    .frame(width: min(geo.size.width, geo.size.width * progress))
                    .animation(.linear)
                
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
