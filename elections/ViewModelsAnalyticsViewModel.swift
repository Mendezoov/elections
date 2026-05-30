//
//  AnalyticsViewModel.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import Foundation
import SwiftData

@MainActor
@Observable
class AnalyticsViewModel {
    var lists: [ElectionList] = []
    var candidates: [Candidate] = []
    var votes: [Vote] = []
    var isAuthenticated: Bool = false
    var showLoginSheet: Bool = false
    var username: String = ""
    var password: String = ""
    var showAuthError: Bool = false
    
    // MARK: - CUSTOMIZE: Change these before distributing the app.
    private let adminUsername = "Mendez"
    private let adminPassword = "12345"
    
    func loadAnalytics(modelContext: ModelContext) {
        do {
            let listDescriptor = FetchDescriptor<ElectionList>()
            lists = try modelContext.fetch(listDescriptor)
            
            let candidateDescriptor = FetchDescriptor<Candidate>()
            candidates = try modelContext.fetch(candidateDescriptor)
            
            let voteDescriptor = FetchDescriptor<Vote>()
            votes = try modelContext.fetch(voteDescriptor)
        } catch {
            print("Error loading analytics: \(error)")
        }
    }
    
    func authenticate() {
        if username == adminUsername && password == adminPassword {
            isAuthenticated = true
            showLoginSheet = false
            username = ""
            password = ""
        } else {
            showAuthError = true
        }
    }
    
    func logout() {
        isAuthenticated = false
        username = ""
        password = ""
    }
    
    var topList: ElectionList? {
        lists.max(by: { $0.voteCount < $1.voteCount })
    }
    
    var topCandidates: [Candidate] {
        candidates.sorted { $0.voteCount > $1.voteCount }.prefix(10).map { $0 }
    }
    
    var totalVotes: Int {
        votes.count
    }
    
    func candidatesForList(_ listName: String) -> [Candidate] {
        candidates.filter { $0.listName == listName }.sorted { $0.voteCount > $1.voteCount }
    }
}
