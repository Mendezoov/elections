//
//  ElectionList.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class ElectionList {
    var id: UUID
    var name: String
    var voteCount: Int
    var colorStart: String // Hex color for gradient start
    var colorEnd: String // Hex color for gradient end
    
    init(name: String, voteCount: Int = 0, colorStart: String, colorEnd: String) {
        self.id = UUID()
        self.name = name
        self.voteCount = voteCount
        self.colorStart = colorStart
        self.colorEnd = colorEnd
    }
}
