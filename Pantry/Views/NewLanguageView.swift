//
//  NewLanguageView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//
import SwiftUI

struct DailyChallengeView: View {
    @State private var selectedTab = 0
    let onAcceptChallenge: () -> Void  // Navigation closure for accepting challenge
    let onChatTap: () -> Void          // Navigation closure for chat
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button(action: {
                    // Handle back action at higher level if needed
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Daily Challenge")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .opacity(0)
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)
            .padding(.bottom, 20)
            
            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: 24) {
                        Text("Learn a New Language")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                        
                        Text("Start your language learning journey today! Choose a language that excites you and dive into a beginner's lesson to learn basic greetings and common phrases.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .lineSpacing(4)
                            .padding(.horizontal, 24)
                        
                        VStack(spacing: 20) {
                            HStack {
                                Text("Estimated Time")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("30 minutes")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                            }
                            
                            HStack {
                                Text("Difficulty")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("Easy")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.green.opacity(0.1))
                                    )
                            }
                        }
                        .padding(24)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                        )
                        .padding(.horizontal, 24)
                    }
                    .padding(.top, 32)
                    
                    Spacer(minLength: 200)
                }
            }
            
            VStack(spacing: 20) {
                Button(action: onAcceptChallenge) {
                    Text("Accept Challenge")
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
                
                HStack(spacing: 0) {
                    TabBarItem(
                        icon: "house.fill",
                        title: "Home",
                        isSelected: selectedTab == 0
                    ) {
                        selectedTab = 0
                    }
                    
                    Spacer()
                    TabBarItem(
                        icon: "message.fill",
                        title: "Chat",
                        isSelected: selectedTab == 1
                    ) {
                        selectedTab = 1
                        onChatTap()
                    }
                    
                    Spacer()
                    
                    TabBarItem(
                        icon: "person.fill",
                        title: "Profile",
                        isSelected: selectedTab == 2
                    ) {
                        selectedTab = 2
                    }
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 16)
                .background(Color.white)
            }
        }
        .background(Color(red: 0.97, green: 0.97, blue: 0.98))
    }
}

struct TabBarItem: View {
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

// Modern preview syntax
#Preview {
    DailyChallengeView(
        onAcceptChallenge: {},
        onChatTap: {}
    )
}
