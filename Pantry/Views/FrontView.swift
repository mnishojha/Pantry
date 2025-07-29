//
//  FrontView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//

import SwiftUI

struct ChallengelyWelcomeView: View {
    let onContinue: () -> Void

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack(spacing: 32) {
                    Spacer()

                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)

                        Image(systemName: "trophy.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.blue)
                    }

                    VStack(spacing: 8) {
                        Text("Welcome to")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)

                        Text("Pantry")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.blue)
                    }

                    Text("Your daily dose of personalized challenges to help you grow and achieve your goals.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .lineSpacing(4)

                    Spacer()
                }
                .frame(maxHeight: .infinity)

                VStack {
                    Button(action: onContinue) {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.purple]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(28)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, max(40, geometry.safeAreaInsets.bottom + 20))
                }
            }
        }
        .background(Color(red: 0.97, green: 0.97, blue: 0.98))
        .ignoresSafeArea()
    }
}


#Preview {
    ChallengelyWelcomeView {
        print("Get Started tapped in preview")
    }
}
