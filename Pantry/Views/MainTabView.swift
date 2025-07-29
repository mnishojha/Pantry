//
//  MainTabView.swift
//  Pantry
//
//  Created by manish ojha on 29/07/25.
//import SwiftUI
//
//struct MainTabView: View {
//    @State private var selectedTab: Int? = 0
//    
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 0) {
//                // Navigation to Completion View
//                NavigationLink(
//                    destination: ChallengeCompletionView(),
//                    tag: 1,
//                    selection: $selectedTab
//                ) { EmptyView() }
//                
//                // Navigation to Interests View
//                NavigationLink(
//                    destination: ChallengelyInterestsView(onContinue: {
//                        selectedTab = 3 // Go to Level View
//                    }),
//                    tag: 2,
//                    selection: $selectedTab
//                ) { EmptyView() }
//                
//                // Navigation to Level View
//                NavigationLink(
//                    destination: ChallengeLevelView(),
//                    tag: 3,
//                    selection: $selectedTab
//                ) { EmptyView() }
//                
//                // Navigation to Chat View
//                NavigationLink(
//                    destination: ChallengeChatAssistantView(),
//                    tag: 4,
//                    selection: $selectedTab
//                ) { EmptyView() }
//                
//                // Starting View
//                ChallengelyWelcomeView(onContinue: {
//                    selectedTab = 2 // Go to Interests View
//                })
//            }
//        }
//    }
//}
//
//// Preview Provider
//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
//
//// Modern SwiftUI preview syntax alternative:
//#Preview {
//    MainTabView()
//}
