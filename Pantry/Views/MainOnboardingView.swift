//
//  MainOnboardingView.swift
//  Pantry
//
//  Created by manish ojha on 30/07/25.
//
//
import SwiftUI

struct MainOnboardingView: View {
    @State private var currentStep: OnboardingStep = .welcome

    var body: some View {
        NavigationStack {
            switch currentStep {
            case .welcome:
                ChallengelyWelcomeView {
                    currentStep = .interests
                }

            case .interests:
                ChallengelyInterestsView {
                    currentStep = .level
                }

            case .level:
                ChallengeLevelView {
                    currentStep = .completion
                }

            case .completion:
                ChallengeCompletionView {
                    currentStep = .chat
                }

            case .chat:
                ChallengeChatAssistantView()
            }
        }
    }

    // ✅ Renamed to avoid conflict with your other ChallengeStep type
    enum OnboardingStep {
        case welcome, interests, level, completion, chat
    }
}

#Preview {
    MainOnboardingView()
}
