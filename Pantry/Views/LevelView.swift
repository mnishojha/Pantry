//
//  LevelView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//
import SwiftUI

enum ChallengeLevel: CaseIterable {
    case easy, medium, hard
    
    var title: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }
    
    var description: String {
        switch self {
        case .easy: return "Quick, simple tasks that fit perfectly into a busy day."
        case .medium: return "Engaging challenges that require some dedicated effort."
        case .hard: return "Demanding tasks designed to truly push your limits."
        }
    }
    
    var icon: String {
        switch self {
        case .easy: return "checkmark.circle.fill"
        case .medium: return "bolt.circle.fill"
        case .hard: return "flame.circle.fill"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .easy: return .green
        case .medium: return .blue
        case .hard: return .red
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .easy: return Color.green.opacity(0.1)
        case .medium: return Color.blue.opacity(0.1)
        case .hard: return Color.red.opacity(0.1)
        }
    }
}

struct ChallengeLevelView: View {
    @State private var selectedLevel: ChallengeLevel = .medium
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button and progress bar
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                
                // Progress bar
                HStack(spacing: 8) {
                    // First segment (completed)
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 60, height: 4)
                        .cornerRadius(2)
                    
                    // Second segment (active)
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 60, height: 4)
                        .cornerRadius(2)
                    
                    // Inactive segments
                    ForEach(0..<2, id: \.self) { _ in
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 4)
                            .cornerRadius(2)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            
            // Main content
            ScrollView {
                VStack(spacing: 32) {
                    // Title and description
                    VStack(spacing: 16) {
                        Text("Set Your Challenge Level")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        Text("How tough do you want your challenges to be? You can always change this later.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                    
                    // Level slider visualization
                    VStack(spacing: 24) {
                        // Slider track with indicator
                        ZStack {
                            // Background track
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 4)
                                .cornerRadius(2)
                            
                            // Active indicator
                            HStack {
                                if selectedLevel == .easy {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                    Spacer()
                                } else if selectedLevel == .medium {
                                    Spacer()
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                    Spacer()
                                } else {
                                    Spacer()
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        
                        // Level labels
                        HStack {
                            Text("Easy")
                                .font(.system(size: 14, weight: selectedLevel == .easy ? .semibold : .regular))
                                .foregroundColor(selectedLevel == .easy ? .black : .gray)
                            
                            Spacer()
                            
                            Text("Medium")
                                .font(.system(size: 14, weight: selectedLevel == .medium ? .semibold : .regular))
                                .foregroundColor(selectedLevel == .medium ? .black : .gray)
                            
                            Spacer()
                            
                            Text("Hard")
                                .font(.system(size: 14, weight: selectedLevel == .hard ? .semibold : .regular))
                                .foregroundColor(selectedLevel == .hard ? .black : .gray)
                        }
                        .padding(.horizontal, 24)
                    }
                    
                    // Level options
                    VStack(spacing: 16) {
                        ForEach(ChallengeLevel.allCases, id: \.title) { level in
                            LevelOptionCard(
                                level: level,
                                isSelected: selectedLevel == level
                            ) {
                                selectedLevel = level
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 120)
                }
            }
            
            // Complete Profile button
            VStack {
                Button(action: {
                    // Handle complete profile action
                    print("Complete Profile tapped with level: \(selectedLevel.title)")
                }) {
                    Text("Complete Profile")
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
                .padding(.bottom, 40)
            }
            .background(Color.white)
        }
        .background(Color(red: 0.97, green: 0.97, blue: 0.98))
        .navigationBarHidden(true)
    }
}

struct LevelOptionCard: View {
    let level: ChallengeLevel
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Icon
                ZStack {
                    Circle()
                        .fill(level.iconColor.opacity(0.2))
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: level.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(level.iconColor)
                }
                
                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(level.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    
                    Text(level.description)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(2)
                }
                
                Spacer()
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                isSelected ? Color.blue : Color.clear,
                                lineWidth: 2
                            )
                    )
                    .shadow(
                        color: isSelected ? Color.blue.opacity(0.2) : Color.black.opacity(0.05),
                        radius: isSelected ? 8 : 4,
                        x: 0,
                        y: 2
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Preview
struct ChallengeLevelView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChallengeLevelView()
        }
    }
}
