//
//  AuthenticationViewModel.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import Foundation
import SwiftData

@MainActor
@Observable
class AuthenticationViewModel {
    var voterID: String = ""
    var isAuthenticated: Bool = false
    var showAlert: Bool = false
    var alertMessage: String = ""
    var currentVoter: Voter?
    
    func validateVoterID(modelContext: ModelContext) {
        // Remove any whitespace
        let trimmedID = voterID.trimmingCharacters(in: .whitespaces)
        
        // Check if ID is 9 digits
        guard trimmedID.count == 9, trimmedID.allSatisfy({ $0.isNumber }) else {
            alertMessage = "رقم هويه غير معرف لا تستطيع التصويت"
            showAlert = true
            return
        }
        
        // Fetch voter from database
        let descriptor = FetchDescriptor<Voter>(
            predicate: #Predicate { voter in
                voter.idNumber == trimmedID
            }
        )
        
        do {
            let voters = try modelContext.fetch(descriptor)
            
            if let voter = voters.first {
                // Voter exists, check if already voted
                if voter.hasVoted {
                    alertMessage = "لقد قمت بالتصويت بالفعل ادخل رقم هويه مختلف"
                    showAlert = true
                } else {
                    // Valid voter, can proceed
                    currentVoter = voter
                    isAuthenticated = true
                }
            } else {
                // Voter not found
                alertMessage = "رقم هويه غير معرف لا تستطيع التصويت"
                showAlert = true
            }
        } catch {
            alertMessage = "حدث خطأ، حاول مرة أخرى"
            showAlert = true
        }
    }
    
    func reset() {
        voterID = ""
        isAuthenticated = false
        currentVoter = nil
        showAlert = false
        alertMessage = ""
    }
}
