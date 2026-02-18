//
//  CandidatesView.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import SwiftUI
import SwiftData

struct CandidatesView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = VotingViewModel()
    let voter: Voter
    
    @State private var showSuccessMessage = false
    @State private var navigateToLogin = false
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [Color(hex: "F5F7FA"), Color(hex: "C3CFE2")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Header
                    VStack(spacing: 8) {
                        Text("اختر قائمتك")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(Color(hex: "2C3E50"))
                        
                        Text("اختر قائمة واحدة ثم اختر حتى 5 مرشحين")
                            .font(.headline)
                            .foregroundColor(Color(hex: "7F8C8D"))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Lists
                    ForEach(viewModel.lists, id: \.id) { list in
                        ListCardView(
                            list: list,
                            isSelected: viewModel.selectedListName == list.name,
                            isDisabled: viewModel.selectedListName != nil && viewModel.selectedListName != list.name,
                            candidates: viewModel.candidates.filter { $0.listName == list.name }.sorted { $0.position < $1.position },
                            selectedCandidates: viewModel.selectedCandidates,
                            onListTap: {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                    viewModel.selectList(list.name)
                                }
                            },
                            onCandidateTap: { candidateName in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    viewModel.toggleCandidate(candidateName)
                                }
                            }
                        )
                    }
                    
                    // Vote Button
                    Button(action: {
                        viewModel.submitVote(voter: voter, modelContext: modelContext)
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                            
                            Text("اضغط للتصويت")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70)
                    }
                    .buttonStyle(.plain)
                    .background(
                        Group {
                            if viewModel.canSubmitVote {
                                LinearGradient(
                                    colors: [Color(hex: "2ECC71"), Color(hex: "27AE60")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            } else {
                                LinearGradient(
                                    colors: [Color.gray, Color.gray.opacity(0.8)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            }
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(
                        color: viewModel.canSubmitVote ? Color(hex: "2ECC71").opacity(0.5) : .clear,
                        radius: 15,
                        x: 0,
                        y: 8
                    )
                    .scaleEffect(viewModel.canSubmitVote ? 1.0 : 0.98)
                    .disabled(!viewModel.canSubmitVote)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: viewModel.canSubmitVote)
                }
                .padding(.horizontal, 20)
            }
            
            // Success overlay
            if showSuccessMessage {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                
                VStack(spacing: 24) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(Color(hex: "2ECC71"))
                    
                    Text("تم التصويت بنجاح!")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color(hex: "2C3E50"))
                    
                    Text("شكراً لمشاركتك في الانتخابات")
                        .font(.title3)
                        .foregroundColor(Color(hex: "7F8C8D"))
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            viewModel.shouldNavigateBack = true
                        }
                    }) {
                        HStack(spacing: 12) {
                            Text("متابعة")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Image(systemName: "arrow.left.circle.fill")
                                .font(.title2)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                    }
                    .buttonStyle(.plain)
                    .background(
                        LinearGradient(
                            colors: [Color(hex: "3498DB"), Color(hex: "2980B9")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: Color(hex: "3498DB").opacity(0.4), radius: 10, x: 0, y: 5)
                    .padding(.top, 10)
                }
                .padding(40)
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 15)
                )
                .padding(.horizontal, 40)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.loadData(modelContext: modelContext)
        }
        .onChange(of: viewModel.showSuccessAlert) { _, newValue in
            if newValue {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    showSuccessMessage = true
                }
            }
        }
        .onChange(of: viewModel.shouldNavigateBack) { _, newValue in
            if newValue {
                // Dismiss back to login view
                dismiss()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CandidatesView(voter: Voter(idNumber: "123456789"))
            .modelContainer(for: [Voter.self, ElectionList.self, Candidate.self, Vote.self])
    }
}
