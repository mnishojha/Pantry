//
//  ContentView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToChallengeLevel = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to the App")
                    .font(.largeTitle)
                    .padding()

                Button(action: {
                    navigateToChallengeLevel = true
                }) {
                    Text("Go to Challenge Level")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                // Navigation trigger
                NavigationLink(
                    destination: ChallengeLevelView {
                        print("Challenge Completed")
                    },
                    isActive: $navigateToChallengeLevel
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
        }
    }
}

#Preview {
    ContentView()
}
