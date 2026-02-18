//
//  electionsApp.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import SwiftUI
import SwiftData

@main
struct electionsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Voter.self, ElectionList.self, Candidate.self, Vote.self])
    }
}
