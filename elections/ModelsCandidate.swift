//
//  Candidate.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import Foundation
import SwiftData

@Model
final class Candidate {
    var id: UUID
    var name: String
    var listName: String
    var position: Int
    var voteCount: Int
    
    init(name: String, listName: String, position: Int, voteCount: Int = 0) {
        self.id = UUID()
        self.name = name
        self.listName = listName
        self.position = position
        self.voteCount = voteCount
    }
}
