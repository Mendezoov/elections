//
//  Voter.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import Foundation
import SwiftData

@Model
final class Voter {
    @Attribute(.unique) var idNumber: String
    var hasVoted: Bool
    var votedAt: Date?
    
    init(idNumber: String, hasVoted: Bool = false, votedAt: Date? = nil) {
        self.idNumber = idNumber
        self.hasVoted = hasVoted
        self.votedAt = votedAt
    }
}
