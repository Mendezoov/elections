//
//  ListCardView.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import SwiftUI

struct ListCardView: View {
    let list: ElectionList
    let isSelected: Bool
    let isDisabled: Bool
    let candidates: [Candidate]
    let selectedCandidates: Set<String>
    let onListTap: () -> Void
    let onCandidateTap: (String) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // List Header - Always visible
            Button(action: onListTap) {
                HStack {
                    // Selection indicator
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // List name
                    Text(list.name)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.6)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    // Expand/collapse indicator
                    Image(systemName: isSelected ? "chevron.up" : "chevron.down")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .padding(24)
                .background(
                    LinearGradient(
                        colors: [Color(hex: list.colorStart), Color(hex: list.colorEnd)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            }
            .disabled(isDisabled)
            
            // Candidates list - Shows when selected
            if isSelected {
                VStack(spacing: 0) {
                    ForEach(candidates, id: \.id) { candidate in
                        CandidateRowView(
                            candidate: candidate,
                            isSelected: selectedCandidates.contains(candidate.name),
                            canSelect: selectedCandidates.count < 5 || selectedCandidates.contains(candidate.name),
                            onTap: {
                                onCandidateTap(candidate.name)
                            }
                        )
                        
                        if candidate.id != candidates.last?.id {
                            Divider()
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    // Selection counter
                    HStack {
                        Spacer()
                        Text("تم اختيار \(selectedCandidates.count) من 5")
                            .font(.headline)
                            .foregroundColor(selectedCandidates.count >= 5 ? Color(hex: "2ECC71") : Color(hex: "95A5A6"))
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                    }
                    .background(Color(hex: "ECF0F1"))
                }
                .background(Color.white)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .cornerRadius(20)
        .shadow(
            color: isSelected ? Color(hex: list.colorStart).opacity(0.4) : .black.opacity(0.1),
            radius: isSelected ? 20 : 10,
            x: 0,
            y: isSelected ? 10 : 5
        )
        .opacity(isDisabled ? 0.5 : 1.0)
        .scaleEffect(isDisabled ? 0.98 : 1.0)
        .overlay(
            Group {
                if isDisabled {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.05))
                }
            }
        )
    }
}

#Preview {
    let sampleList = ElectionList(name: "قائمة بطيخ", colorStart: "4A90E2", colorEnd: "7B68EE")
    let sampleCandidates = [
        Candidate(name: "عاكف الجبر", listName: "قائمة بطيخ", position: 1),
        Candidate(name: "يأجوج ومأجوج", listName: "قائمة بطيخ", position: 2),
        Candidate(name: "المهدي المنتظر", listName: "قائمة بطيخ", position: 3)
    ]
    
    return ListCardView(
        list: sampleList,
        isSelected: true,
        isDisabled: false,
        candidates: sampleCandidates,
        selectedCandidates: ["عاكف الجبر"],
        onListTap: {},
        onCandidateTap: { _ in }
    )
    .padding()
}
