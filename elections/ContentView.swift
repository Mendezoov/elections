//
//  ContentView.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var hasSeenOnboarding = false
    @State private var showAnalytics = false
    
    var body: some View {
        ZStack {
            if !hasSeenOnboarding {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
                    .transition(.opacity)
            } else {
                NavigationStack {
                    LoginView()
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button(action: {
                                    showAnalytics = true
                                }) {
                                    HStack {
                                        Text("Management Screen")
                                            .font(.headline)
                                        Image(systemName: "chart.bar.fill")
                                    }
                                    .foregroundColor(Color(hex: "3498DB"))
                                }
                            }
                        }
                }
                .transition(.opacity)
            }
        }
        .sheet(isPresented: $showAnalytics) {
            AnalyticsView()
        }
        .onAppear {
            // Setup initial data
            DataService.shared.setupInitialData(modelContext: modelContext)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Voter.self, ElectionList.self, Candidate.self, Vote.self])
}
