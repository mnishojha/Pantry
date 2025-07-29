//
//  CompletionView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//
import SwiftUI

struct ChallengeCompletionView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedTab = 0
    @State private var animateConfetti = false
    @State private var animateTrophy = false
    @State private var navigateToHome = false
    @State private var navigateToChat = false
    @State private var navigateToProfile = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.97, green: 0.97, blue: 0.98)
                    .ignoresSafeArea()

                if animateConfetti {
                    ConfettiView()
                }

                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)

                    ScrollView {
                        VStack(spacing: 32) {
                            Spacer(minLength: 40)

                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 0.96, green: 0.83, blue: 0.40),
                                                Color(red: 0.85, green: 0.65, blue: 0.13)
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 150, height: 120)
                                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)

                                Image(systemName: "trophy.fill")
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(Color(red: 0.4, green: 0.3, blue: 0.1))
                            }
                            .scaleEffect(animateTrophy ? 1.0 : 0.8)
                            .animation(.spring(response: 0.6, dampingFraction: 0.7), value: animateTrophy)

                            VStack(spacing: 8) {
                                Text("Challenge")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.black)

                                Text("Completed!")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.black)
                            }
                            .multilineTextAlignment(.center)

                            VStack(spacing: 20) {
                                VStack(spacing: 8) {
                                    Text("Daily Challenge")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.gray)

                                    Text("Complete 10,000 steps")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.blue)
                                }

                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 1)

                                HStack(spacing: 12) {
                                    Image(systemName: "flame.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.orange)

                                    Text("Current Streak:")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.black)

                                    Spacer()

                                    Text("3 days")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding(24)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                            )
                            .padding(.horizontal, 24)

                            Spacer(minLength: 100)
                        }
                    }

                    VStack(spacing: 20) {
                        Button(action: {
                            print("Share Your Achievement tapped")
                        }) {
                            HStack(spacing: 8) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("Share Your Achievement")
                                    .font(.system(size: 18, weight: .semibold))
                            }
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

                        HStack(spacing: 0) {
                            CompletionTabBarItem(
                                icon: "house.fill",
                                title: "Home",
                                isSelected: selectedTab == 0
                            ) {
                                selectedTab = 0
                                navigateToHome = true
                            }

                            Spacer()

                            CompletionTabBarItem(
                                icon: "message.fill",
                                title: "Chat",
                                isSelected: selectedTab == 1
                            ) {
                                selectedTab = 1
                                navigateToChat = true
                            }

                            Spacer()

                            CompletionTabBarItem(
                                icon: "person.fill",
                                title: "Profile",
                                isSelected: selectedTab == 2
                            ) {
                                selectedTab = 2
                                navigateToProfile = true
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 16)
                        .background(Color.white)
                    }
                }

                // Navigation Links
                NavigationLink("", destination: HomeView(), isActive: $navigateToHome)
                NavigationLink("", destination: ChallengeChatAssistantView(), isActive: $navigateToChat)

                NavigationLink("", destination: ProfileView(), isActive: $navigateToProfile)
            }
            .navigationBarHidden(true)
            .onAppear {
                withAnimation(.easeOut(duration: 0.5)) {
                    animateConfetti = true
                }
                withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.2)) {
                    animateTrophy = true
                }
            }
        }
    }
}

// Replace ChatView with your AssistantBotView
struct AssistantBotView: View {
    var body: some View {
        Text("Assistant Bot")
            .font(.largeTitle)
            .bold()
    }
}

struct HomeView: View {
    var body: some View {
        Text("Home View")
            .font(.largeTitle)
            .bold()
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile View")
            .font(.largeTitle)
            .bold()
    }
}

struct CompletionTabBarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(isSelected ? .blue : .gray)
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ConfettiView: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            ForEach(0..<15, id: \.self) { index in
                ConfettiPiece(index: index)
                    .offset(
                        x: animate ? CGFloat.random(in: -200...200) : 0,
                        y: animate ? CGFloat.random(in: 300...800) : -50
                    )
                    .rotationEffect(.degrees(animate ? Double.random(in: 0...360) : 0))
                    .animation(
                        .easeOut(duration: Double.random(in: 2...4)).delay(Double.random(in: 0...0.5)),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}

struct ConfettiPiece: View {
    let index: Int

    var colors: [Color] = [.blue, .orange, .pink, .yellow, .purple, .green]

    var body: some View {
        Rectangle()
            .fill(colors[index % colors.count])
            .frame(width: 8, height: 8)
            .cornerRadius(2)
    }
}

struct ChallengeCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeCompletionView()
    }
}
