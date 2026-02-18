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
                ElectionList(name: "قائمة كفر الديك الالولى", colorStart: "4A90E2", colorEnd: "7B68EE"),
                ElectionList(name: "قائمة كفر الديك الثانية", colorStart: "2ECC71", colorEnd: "1ABC9C"),
                ElectionList(name: "قائمة كفر الديك الثالثة", colorStart: "E74C3C", colorEnd: "F39C12")
            ]
            
            for list in lists {
                modelContext.insert(list)
            }
        }
        
        // Check if candidates already exist
        let candidateDescriptor = FetchDescriptor<Candidate>()
        let existingCandidates = try? modelContext.fetch(candidateDescriptor)
        
        if existingCandidates?.isEmpty ?? true {
            // List 1: قائمة كفر الديك الالولى
            let list1Candidates = [
                Candidate(name: "احمد", listName: "قائمة كفر الديك الالولى", position: 1),
                Candidate(name: "يأجوج ومأجوج", listName: "قائمة كفر الديك الالولى", position: 2),
                Candidate(name: "المهدي المنتظر", listName: "قائمة كفر الديك الالولى", position: 3),
                Candidate(name: "مرشح رابع للقائمة الالولى", listName: "قائمة كفر الديك الالولى", position: 4),
                Candidate(name: "مرشح خامس للقائمة الالولى", listName: "قائمة كفر الديك الالولى", position: 5),
                Candidate(name: "مرشح سادس للقائمة الالولى", listName: "قائمة كفر الديك الالولى", position: 6)
            ]
            
            // List 2: قائمة كفر الديك الثانية
            let list2Candidates = [
                Candidate(name: "ريتا", listName: "قائمة كفر الديك الثانية", position: 1),
                Candidate(name: "مرشح ثاني للقائمة الثانية", listName: "قائمة كفر الديك الثانية", position: 2),
                Candidate(name: "مرشح ثالث للقائمة الثانية", listName: "قائمة كفر الديك الثانية", position: 3),
                Candidate(name: "مرشح رابع للقائمة الثانية", listName: "قائمة كفر الديك الثانية", position: 4),
                Candidate(name: "مرشح خامس للقائمة الثانية", listName: "قائمة كفر الديك الثانية", position: 5),
                Candidate(name: "مرشح سادس للقائمة الثانية", listName: "قائمة كفر الديك الثانية", position: 6)
            ]
            
            // List 3: قائمة كفر الديك الثالثة
            let list3Candidates = [
                Candidate(name: "ططلي", listName: "قائمة كفر الديك الثالثة", position: 1),
                Candidate(name: "مرشح ثاني للقائمة الثالثة", listName: "قائمة كفر الديك الثالثة", position: 2),
                Candidate(name: "مرشح ثالث للقائمة الثالثة", listName: "قائمة كفر الديك الثالثة", position: 3),
                Candidate(name: "مرشح رابع للقائمة الثالثة", listName: "قائمة كفر الديك الثالثة", position: 4),
                Candidate(name: "مرشح خامس للقائمة الثالثة", listName: "قائمة كفر الديك الثالثة", position: 5),
                Candidate(name: "مرشح سادس للقائمة الثالثة", listName: "قائمة كفر الديك الثالثة", position: 6)
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
