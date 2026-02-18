//
//  CandidateRowView.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import SwiftUI

struct CandidateRowView: View {
    let candidate: Candidate
    let isSelected: Bool
    let canSelect: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Selection checkbox
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color(hex: "2ECC71") : Color(hex: "BDC3C7"), lineWidth: 2)
                        .frame(width: 28, height: 28)
                    
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(hex: "2ECC71"))
                    }
                }
                
                // Position number
                Text("\(candidate.position)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "34495E"))
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(isSelected ? Color(hex: "2ECC71").opacity(0.2) : Color(hex: "ECF0F1"))
                    )
                
                // Candidate name
                Text(candidate.name)
                    .font(.title3)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundColor(Color(hex: "2C3E50"))
                
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .background(isSelected ? Color(hex: "2ECC71").opacity(0.1) : Color.white)
        }
        .disabled(!canSelect && !isSelected)
        .opacity(canSelect || isSelected ? 1.0 : 0.5)
    }
}

#Preview {
    VStack {
        CandidateRowView(
            candidate: Candidate(name: "عاكف الجبر", listName: "قائمة بطيخ", position: 1),
            isSelected: true,
            canSelect: true,
            onTap: {}
        )
        
        CandidateRowView(
            candidate: Candidate(name: "يأجوج ومأجوج", listName: "قائمة بطيخ", position: 2),
            isSelected: false,
            canSelect: true,
            onTap: {}
        )
        
        CandidateRowView(
            candidate: Candidate(name: "المهدي المنتظر", listName: "قائمة بطيخ", position: 3),
            isSelected: false,
            canSelect: false,
            onTap: {}
        )
    }
}
