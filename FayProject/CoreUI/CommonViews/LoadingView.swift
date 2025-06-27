//
//  LoadingView.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import SwiftUI

import SwiftUI

struct LoadingView: View {
    @State private var isRotating = 0.0
    
    var body: some View {
        ZStack {
            AngularGradient(
                gradient: Gradient(colors: [Color.primaryTheme.opacity(0.3), Color.primaryTheme.opacity(0.6), Color.primaryTheme.opacity(0.3)]),
                center: .center,
                startAngle: .degrees(0),
                endAngle: .degrees(360)
            )
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .blur(radius: 10)
            
            Circle()
                .trim(from: 0.0, to: 0.5)
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.secondaryText, Color.clear]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .frame(width: 80, height: 80)
                .rotationEffect(.degrees(isRotating))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isRotating)
                .onAppear {
                    withAnimation {
                        isRotating = 360.0
                    }
                }
        }
    }
}

#Preview {
    LoadingView()
}
