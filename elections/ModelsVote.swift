//
//  Vote.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import Foundation
import SwiftData

@Model
final class Vote {
    var id: UUID
    var voterID: String
    var selectedListName: String
    var selectedCandidateNames: [String]
    var timestamp: Date
    
    init(voterID: String, selectedListName: String, selectedCandidateNames: [String], timestamp: Date = Date()) {
        self.id = UUID()
        self.voterID = voterID
        self.selectedListName = selectedListName
        self.selectedCandidateNames = selectedCandidateNames
        self.timestamp = timestamp
    }
}
