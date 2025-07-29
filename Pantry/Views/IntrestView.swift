//
//  IntrestView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//


import SwiftUI
import SwiftUI

struct Interest: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    var isSelected: Bool
}

struct ChallengelyInterestsView: View {
    @State private var interests = [
        Interest(name: "Fitness", icon: "dumbbell.fill", isSelected: true),
        Interest(name: "Creativity", icon: "paintbrush.fill", isSelected: true),
        Interest(name: "Mindfulness", icon: "hands.and.sparkles.fill", isSelected: true),
        Interest(name: "Learning", icon: "book.fill", isSelected: false),
        Interest(name: "Social", icon: "person.2.fill", isSelected: false)
    ]

    let onContinue: () -> Void

    var selectedCount: Int {
        interests.filter { $0.isSelected }.count
    }

    var canContinue: Bool {
        selectedCount >= 3
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Choose your interests")
                        .font(.title)
                        .bold()

                    Text("Select at least 3 to personalize your challenges.")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(Array(interests.enumerated()), id: \.element.id) { index, interest in
                            Button(action: {
                                interests[index].isSelected.toggle()
                            }) {
                                VStack(spacing: 10) {
                                    Image(systemName: interest.icon)
                                        .font(.system(size: 28))
                                        .foregroundColor(interest.isSelected ? .white : .blue)
                                        .padding()
                                        .background(interest.isSelected ? Color.blue : Color.gray.opacity(0.2))
                                        .clipShape(Circle())

                                    Text(interest.name)
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white)
                                        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }

            Button(action: {
                if canContinue {
                    onContinue()
                }
            }) {
                Text("Continue")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(canContinue ? Color.blue : Color.gray.opacity(0.4))
                    .cornerRadius(20)
            }
            .padding()
            .disabled(!canContinue)
        }
    }
}

#Preview {
    ChallengelyInterestsView(onContinue: {})
}
