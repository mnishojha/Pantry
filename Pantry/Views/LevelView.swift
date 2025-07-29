//
//  LevelView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//
import SwiftUI

struct ChallengeLevelView: View {
    @State private var selectedLevel: ChallengeLevel = .medium
    let onCompletion: () -> Void  // ✅ closure from MainOnboardingView

    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)

                // Progress bar
                HStack(spacing: 8) {
                    Rectangle().fill(Color.blue).frame(width: 60, height: 4).cornerRadius(2)
                    Rectangle().fill(Color.blue).frame(width: 60, height: 4).cornerRadius(2)
                    ForEach(0..<2) { _ in
                        Rectangle().fill(Color.gray.opacity(0.3)).frame(width: 60, height: 4).cornerRadius(2)
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
            }

            ScrollView {
                VStack(spacing: 32) {
                    // Title
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

                    // Level Slider mimic
                    VStack(spacing: 24) {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 4)
                                .cornerRadius(2)

                            HStack {
                                if selectedLevel == .easy {
                                    Circle().fill(Color.blue).frame(width: 20, height: 20)
                                } else if selectedLevel == .medium {
                                    Spacer()
                                    Circle().fill(Color.blue).frame(width: 20, height: 20)
                                    Spacer()
                                } else {
                                    Spacer()
                                    Spacer()
                                    Circle().fill(Color.blue).frame(width: 20, height: 20)
                                }
                            }
                        }
                        .padding(.horizontal, 24)

                        // Labels
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

                    // Level Cards
                    VStack(spacing: 16) {
                        ForEach(ChallengeLevel.allCases, id: \.title) { level in
                            LevelOptionCard(level: level, isSelected: selectedLevel == level) {
                                selectedLevel = level
                            }
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer(minLength: 120)
                }
            }

            // Continue Button
            Button(action: {
                print("Selected level: \(selectedLevel.title)")
                onCompletion()  // ✅ triggers navigation to next screen
            }) {
                Text("Complete Profile")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.blue]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(28)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 40)
        }
        .background(Color(red: 0.97, green: 0.97, blue: 0.98))
        .navigationBarHidden(true)
    }
}

// Supporting Views & Models
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
}

struct LevelOptionCard: View {
    let level: ChallengeLevel
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(level.iconColor.opacity(0.2))
                        .frame(width: 48, height: 48)
                    Image(systemName: level.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(level.iconColor)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(level.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                    Text(level.description)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }

                Spacer()
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
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
        ChallengeLevelView {
            // do nothing in preview
        }
    }
}
