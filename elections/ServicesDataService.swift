//
//  DataService.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import Foundation
import SwiftData

@MainActor
class DataService {
    static let shared = DataService()
    
    private init() {}
    
    func setupInitialData(modelContext: ModelContext) {
        // Check if data already exists
        let voterDescriptor = FetchDescriptor<Voter>()
        let existingVoters = try? modelContext.fetch(voterDescriptor)
        
        if existingVoters?.isEmpty ?? true {
            // Create 5 random voter IDs (9 digits each)
            let voterIDs = [
                "123456789",
                "987654321",
                "456789123",
                "321654987",
                "789123456"
            ]
            
            for id in voterIDs {
                let voter = Voter(idNumber: id)
                modelContext.insert(voter)
            }
        }
        
        // Check if lists already exist
        let listDescriptor = FetchDescriptor<ElectionList>()
        let existingLists = try? modelContext.fetch(listDescriptor)
        
        if existingLists?.isEmpty ?? true {
            // Create three election lists with gradient colors
            let lists = [
                ElectionList(name: "قائمة بطيخ", colorStart: "4A90E2", colorEnd: "7B68EE"),
                ElectionList(name: "قائمة بص حضرتك", colorStart: "2ECC71", colorEnd: "1ABC9C"),
                ElectionList(name: "قائمة غرامك راح", colorStart: "E74C3C", colorEnd: "F39C12")
            ]
            
            for list in lists {
                modelContext.insert(list)
            }
        }
        
        // Check if candidates already exist
        let candidateDescriptor = FetchDescriptor<Candidate>()
        let existingCandidates = try? modelContext.fetch(candidateDescriptor)
        
        if existingCandidates?.isEmpty ?? true {
            // List 1: قائمة بطيخ
            let list1Candidates = [
                Candidate(name: "عاكف الجبر", listName: "قائمة بطيخ", position: 1),
                Candidate(name: "يأجوج ومأجوج", listName: "قائمة بطيخ", position: 2),
                Candidate(name: "المهدي المنتظر", listName: "قائمة بطيخ", position: 3),
                Candidate(name: "شخص من علي زهاف", listName: "قائمة بطيخ", position: 4),
                Candidate(name: "مرشح خامس", listName: "قائمة بطيخ", position: 5),
                Candidate(name: "مرشح سادس", listName: "قائمة بطيخ", position: 6)
            ]
            
            // List 2: قائمة بص حضرتك
            let list2Candidates = [
                Candidate(name: "ربحي الجبر", listName: "قائمة بص حضرتك", position: 1),
                Candidate(name: "مرشح ثاني", listName: "قائمة بص حضرتك", position: 2),
                Candidate(name: "مرشح ثالث", listName: "قائمة بص حضرتك", position: 3),
                Candidate(name: "مرشح رابع", listName: "قائمة بص حضرتك", position: 4),
                Candidate(name: "مرشح خامس", listName: "قائمة بص حضرتك", position: 5),
                Candidate(name: "مرشح سادس", listName: "قائمة بص حضرتك", position: 6)
            ]
            
            // List 3: قائمة غرامك راح
            let list3Candidates = [
                Candidate(name: "ططلي", listName: "قائمة غرامك راح", position: 1),
                Candidate(name: "مرشح ثاني", listName: "قائمة غرامك راح", position: 2),
                Candidate(name: "مرشح ثالث", listName: "قائمة غرامك راح", position: 3),
                Candidate(name: "مرشح رابع", listName: "قائمة غرامك راح", position: 4),
                Candidate(name: "مرشح خامس", listName: "قائمة غرامك راح", position: 5),
                Candidate(name: "مرشح سادس", listName: "قائمة غرامك راح", position: 6)
            ]
            
            let allCandidates = list1Candidates + list2Candidates + list3Candidates
            
            for candidate in allCandidates {
                modelContext.insert(candidate)
            }
        }
        
        // Save all changes
        try? modelContext.save()
    }
}
