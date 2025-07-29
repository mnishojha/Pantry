//
//  CompletionView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
import SwiftUI

struct ChallengeCompletionView: View {
    let onContinue: () -> Void

    @State private var animateTrophy = false
    @State private var animateConfetti = false
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            if animateConfetti {
                ConfettiView()
                    .frame(height: 100) // keep it minimal
            }

            Image(systemName: "trophy.fill")
                .font(.system(size: 64))
                .foregroundColor(.yellow)
                .scaleEffect(animateTrophy ? 1.0 : 0.8)
                .animation(.spring(), value: animateTrophy)

            Text("Challenge Completed!")
                .font(.title)
                .fontWeight(.bold)

            Button("Go to Chat") {
                onContinue()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding(.horizontal)

            Spacer()

            HStack {
                Button(action: { selectedTab = 0 }) {
                    VStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }

                Spacer()

                Button(action: { selectedTab = 1 }) {
                    VStack {
                        Image(systemName: "message.fill")
                        Text("Chat")
                    }
                }

                Spacer()

                Button(action: { selectedTab = 2 }) {
                    VStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear {
            withAnimation(.spring()) {
                animateConfetti = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring()) {
                    animateTrophy = true
                }
            }
        }
    }
}



struct ChallengeCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeCompletionView {
            print("Preview Continue tapped")
        }
    }
}
