//
//  VotingViewModel.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import Foundation
import SwiftData

@MainActor
@Observable
class VotingViewModel {
    var selectedListName: String?
    var selectedCandidates: Set<String> = []
    var lists: [ElectionList] = []
    var candidates: [Candidate] = []
    var showSuccessAlert: Bool = false
    var voteSubmitted: Bool = false
    var shouldNavigateBack: Bool = false
    
    var canSubmitVote: Bool {
        selectedListName != nil
    }
    
    var candidatesForSelectedList: [Candidate] {
        guard let listName = selectedListName else { return [] }
        return candidates.filter { $0.listName == listName }.sorted { $0.position < $1.position }
    }
    
    func loadData(modelContext: ModelContext) {
        do {
            let listDescriptor = FetchDescriptor<ElectionList>()
            let fetchedLists = try modelContext.fetch(listDescriptor)
            
            // Sort lists to ensure correct order: الاولى, الثانية, الثالثة
            lists = fetchedLists.sorted { list1, list2 in
                if list1.name.contains("الاولى") || list1.name.contains("الالولى") {
                    return true
                } else if list2.name.contains("الاولى") || list2.name.contains("الالولى") {
                    return false
                } else if list1.name.contains("الثانية") {
                    return list2.name.contains("الثالثة")
                } else {
                    return false
                }
            }
            
            let candidateDescriptor = FetchDescriptor<Candidate>()
            candidates = try modelContext.fetch(candidateDescriptor)
        } catch {
            print("Error loading data: \(error)")
        }
    }
    
    func selectList(_ listName: String) {
        if selectedListName == listName {
            // Deselect list
            selectedListName = nil
            selectedCandidates.removeAll()
        } else {
            // Select new list
            selectedListName = listName
            selectedCandidates.removeAll()
        }
    }
    
    func toggleCandidate(_ candidateName: String) {
        if selectedCandidates.contains(candidateName) {
            selectedCandidates.remove(candidateName)
        } else {
            // Only allow max 5 candidates
            if selectedCandidates.count < 5 {
                selectedCandidates.insert(candidateName)
            }
        }
    }
    
    func submitVote(voter: Voter, modelContext: ModelContext) {
        guard let listName = selectedListName else { return }
        
        // Create vote record
        let vote = Vote(
            voterID: voter.idNumber,
            selectedListName: listName,
            selectedCandidateNames: Array(selectedCandidates)
        )
        modelContext.insert(vote)
        
        // Update voter status
        voter.hasVoted = true
        voter.votedAt = Date()
        
        // Update list vote count
        if let list = lists.first(where: { $0.name == listName }) {
            list.voteCount += 1
        }
        
        // Update candidate vote counts
        for candidateName in selectedCandidates {
            if let candidate = candidates.first(where: { $0.name == candidateName }) {
                candidate.voteCount += 1
            }
        }
        
        // Save changes
        try? modelContext.save()
        
        voteSubmitted = true
        showSuccessAlert = true
    }
    
    func reset() {
        selectedListName = nil
        selectedCandidates.removeAll()
        voteSubmitted = false
    }
}
