//
//  IntrestView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//

import SwiftUI

struct Interest {
    let id = UUID()
    let name: String
    let icon: String
    var isSelected: Bool = false
}

struct ChallengelyInterestsView: View {
    @State private var interests = [
        Interest(name: "Fitness", icon: "dumbbell.fill", isSelected: true),
        Interest(name: "Creativity", icon: "paintbrush.fill", isSelected: true),
        Interest(name: "Mindfulness", icon: "hands.and.sparkles.fill", isSelected: true),
        Interest(name: "Learning", icon: "book.fill", isSelected: false),
        Interest(name: "Social", icon: "person.2.fill", isSelected: false)
    ]
    
    @Environment(\.presentationMode) var presentationMode
    
    var selectedCount: Int {
        interests.filter { $0.isSelected }.count
    }
    
    var canContinue: Bool {
        selectedCount >= 3
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with back button and progress bar
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                
                // Progress bar
                HStack(spacing: 8) {
                    // Active segment
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 60, height: 4)
                        .cornerRadius(2)
                    
                    // Inactive segments
                    ForEach(0..<3, id: \.self) { _ in
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
                        Text("Choose your interests")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        Text("Select at least 3 to personalize your challenges.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 32)
                    
                    // Interest grid
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16)
                    ], spacing: 16) {
                        ForEach(Array(interests.enumerated()), id: \.element.id) { index, interest in
                            InterestCard(
                                interest: interest,
                                isSelected: interest.isSelected
                            ) {
                                interests[index].isSelected.toggle()
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 120)
                }
            }
            
            // Continue button
            VStack {
                Button(action: {
                    // Handle continue action
                    print("Continue tapped with \(selectedCount) interests selected")
                }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(
                            canContinue ?
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.4, green: 0.7, blue: 1.0),
                                    Color(red: 0.3, green: 0.6, blue: 0.9)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ) :
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.gray.opacity(0.4),
                                    Color.gray.opacity(0.4)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(28)
                }
                .disabled(!canContinue)
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .background(Color.white)
        }
        .background(Color(red: 0.97, green: 0.97, blue: 0.98))
        .navigationBarHidden(true)
    }
}

struct InterestCard: View {
    let interest: Interest
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 16) {
                // Icon circle
                ZStack {
                    Circle()
                        .fill(isSelected ? Color.blue : Color.gray.opacity(0.2))
                        .frame(width: 56, height: 56)
                    
                    Image(systemName: interest.icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(isSelected ? .white : .black)
                }
                
                // Interest name
                Text(interest.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.8))
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                isSelected ? Color.blue : Color.gray.opacity(0.2),
                                lineWidth: isSelected ? 2 : 1
                            )
                    )
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Preview
struct ChallengelyInterestsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChallengelyInterestsView()
        }
    }
}
