//
//  ConffieView.swift
//  Pantry
//
//  Created by manish ojha on 30/07/25.
//
import SwiftUI

struct ConfettiView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            ForEach(0..<20, id: \.self) { i in
                Circle()
                    .fill(randomColor())
                    .frame(width: 8, height: 8)
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: isAnimating ? CGFloat.random(in: 0...200) : -50
                    )
                    .animation(.easeInOut(duration: Double.random(in: 1...2)).repeatForever(autoreverses: false), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }

    func randomColor() -> Color {
        let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple, .pink]
        return colors.randomElement() ?? .black
    }
}
#Preview {
    ConfettiView()
}
