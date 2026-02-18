//
//  LoginView.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color(hex: "ECF0F1"), Color(hex: "BDC3C7")],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Header
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.seal.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color(hex: "3498DB"), Color(hex: "2980B9")],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        
                        Text("تسجيل الدخول")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "2C3E50"))
                    }
                    
                    // ID Input Card
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("رقم الهوية")
                                .font(.headline)
                                .foregroundColor(Color(hex: "34495E"))
                            
                            TextField("ادخل رقم الهوية", text: $viewModel.voterID)
                                .font(.title3)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .padding()
                                .frame(height: 60)
                                .background(Color.white)
                                .cornerRadius(16)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            LinearGradient(
                                                colors: [Color(hex: "3498DB"), Color(hex: "9B59B6")],
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            ),
                                            lineWidth: 2
                                        )
                                )
                                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                        
                        // Login Button
                        Button(action: {
                            viewModel.validateVoterID(modelContext: modelContext)
                        }) {
                            HStack {
                                Text("دخول")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                
                                Image(systemName: "arrow.left.circle.fill")
                                    .font(.title2)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "3498DB"), Color(hex: "2980B9")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(16)
                            .shadow(color: Color(hex: "3498DB").opacity(0.4), radius: 10, x: 0, y: 5)
                        }
                        .disabled(viewModel.voterID.isEmpty)
                        .opacity(viewModel.voterID.isEmpty ? 0.6 : 1.0)
                    }
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color.white.opacity(0.9))
                            .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 10)
                    )
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                CandidatesView(voter: viewModel.currentVoter ?? Voter(idNumber: ""))
            }
            .onChange(of: viewModel.isAuthenticated) { _, newValue in
                // Reset the view model when navigating back
                if !newValue {
                    viewModel.reset()
                }
            }
            .alert("تنبيه", isPresented: $viewModel.showAlert) {
                Button("حسناً", role: .cancel) { }
            } message: {
                Text(viewModel.alertMessage)
                    .font(.title3)
            }
        }
    }
}

#Preview {
    LoginView()
        .modelContainer(for: [Voter.self, ElectionList.self, Candidate.self, Vote.self])
}
