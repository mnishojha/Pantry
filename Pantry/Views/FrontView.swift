//
//  FrontView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//

import SwiftUI

struct ChallengelyWelcomeView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Top section with trophy icon
                VStack(spacing: 32) {
                    Spacer()
                    
                    // Trophy icon in circle
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 80, height: 80)
                            .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.blue)
                    }
                    
                    // Welcome text
                    VStack(spacing: 8) {
                        Text("Welcome to")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Challengely")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.blue)
                    }
                    
                    // Description text
                    Text("Your daily dose of personalized challenges to help you grow and achieve your goals.")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .lineSpacing(4)
                    
                    Spacer()
                }
                .frame(maxHeight: .infinity)
                
                // Get Started button
                VStack {
                    Button(action: {
                        // Handle get started action
                        print("Get Started tapped")
                    }) {
                        Text("Get Started")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.4, green: 0.7, blue: 1.0),
                                        Color(red: 0.3, green: 0.6, blue: 0.9)
                                    ]),
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

// Preview
struct ChallengelyWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengelyWelcomeView()
    }
}

