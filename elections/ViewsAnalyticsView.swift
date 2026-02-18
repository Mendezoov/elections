//
//  AnalyticsView.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import SwiftUI
import SwiftData
import Charts

struct AnalyticsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = AnalyticsViewModel()
    
    var body: some View {
        Group {
            if viewModel.isAuthenticated {
                analyticsContent
            } else {
                loginPrompt
            }
        }
        .onAppear {
            if viewModel.isAuthenticated {
                viewModel.loadAnalytics(modelContext: modelContext)
            }
        }
        .sheet(isPresented: $viewModel.showLoginSheet) {
            adminLoginSheet
        }
    }
    
    private var loginPrompt: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "2C3E50"), Color(hex: "34495E")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: "3498DB"), Color(hex: "9B59B6")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                Text("صفحة الإدارة")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.white)
                
                Text("يرجى تسجيل الدخول للوصول إلى التحليلات")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Button(action: {
                    viewModel.showLoginSheet = true
                }) {
                    HStack {
                        Text("تسجيل الدخول")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "arrow.left.circle.fill")
                            .font(.title2)
                    }
                    .foregroundColor(.white)
                    .frame(width: 250, height: 60)
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
                .shadow(color: Color(hex: "3498DB").opacity(0.5), radius: 15, x: 0, y: 8)
                .padding(.top, 20)
            }
        }
    }
    
    private var adminLoginSheet: some View {
        NavigationStack {
            ZStack {
                Color(hex: "ECF0F1")
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color(hex: "3498DB"))
                    
                    VStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("اسم المستخدم")
                                .font(.headline)
                                .foregroundColor(Color(hex: "34495E"))
                            
                            TextField("Username", text: $viewModel.username)
                                .textFieldStyle(.plain)
                                .padding()
                                .frame(height: 50)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .stroke(Color(hex: "BDC3C7"), lineWidth: 1)
                                )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("كلمة المرور")
                                .font(.headline)
                                .foregroundColor(Color(hex: "34495E"))
                            
                            SecureField("Password", text: $viewModel.password)
                                .textFieldStyle(.plain)
                                .padding()
                                .frame(height: 50)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                                        .stroke(Color(hex: "BDC3C7"), lineWidth: 1)
                                )
                        }
                        
                        Button(action: {
                            viewModel.authenticate()
                            if viewModel.isAuthenticated {
                                viewModel.loadAnalytics(modelContext: modelContext)
                            }
                        }) {
                            Text("دخول")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                        }
                        .buttonStyle(.plain)
                        .background(
                            LinearGradient(
                                colors: [Color(hex: "2ECC71"), Color(hex: "27AE60")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 30)
                }
            }
            .navigationTitle("تسجيل دخول الإدارة")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("إلغاء") {
                        viewModel.showLoginSheet = false
                    }
                }
            }
            .alert("خطأ في تسجيل الدخول", isPresented: $viewModel.showAuthError) {
                Button("حسناً", role: .cancel) { }
            } message: {
                Text("اسم المستخدم أو كلمة المرور غير صحيحة")
            }
        }
    }
    
    private var analyticsContent: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    // Summary Cards
                    HStack(spacing: 16) {
                        SummaryCard(
                            title: "إجمالي الأصوات",
                            value: "\(viewModel.totalVotes)",
                            icon: "chart.bar.fill",
                            color: Color(hex: "3498DB")
                        )
                        
                        SummaryCard(
                            title: "القوائم",
                            value: "\(viewModel.lists.count)",
                            icon: "list.bullet.rectangle.fill",
                            color: Color(hex: "9B59B6")
                        )
                    }
                    .padding(.horizontal)
                    
                    // List Votes Chart
                    VStack(alignment: .leading, spacing: 16) {
                        Text("أصوات القوائم")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "2C3E50"))
                            .padding(.horizontal)
                        
                        if !viewModel.lists.isEmpty {
                            Chart(viewModel.lists, id: \.id) { list in
                                BarMark(
                                    x: .value("القائمة", list.name),
                                    y: .value("الأصوات", list.voteCount)
                                )
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color(hex: list.colorStart), Color(hex: list.colorEnd)],
                                        startPoint: .bottom,
                                        endPoint: .top
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            }
                            .frame(height: 250)
                            .padding(.horizontal)
                        } else {
                            Text("لا توجد بيانات")
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity)
                                .frame(height: 250)
                        }
                    }
                    .padding(.vertical)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .padding(.horizontal)
                    
                    // Top Candidates
                    VStack(alignment: .leading, spacing: 16) {
                        Text("أعلى المرشحين")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "2C3E50"))
                            .padding(.horizontal)
                        
                        ForEach(Array(viewModel.topCandidates.prefix(10).enumerated()), id: \.element.id) { index, candidate in
                            HStack {
                                Text("\(index + 1)")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 35, height: 35)
                                    .background(
                                        Circle()
                                            .fill(rankColor(index))
                                    )
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text(candidate.name)
                                        .font(.headline)
                                        .foregroundColor(Color(hex: "2C3E50"))
                                    
                                    Text(candidate.listName)
                                        .font(.subheadline)
                                        .foregroundColor(Color(hex: "7F8C8D"))
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .leading) {
                                    Text("\(candidate.voteCount)")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(hex: "2ECC71"))
                                    
                                    Text("صوت")
                                        .font(.caption)
                                        .foregroundColor(Color(hex: "95A5A6"))
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                    
                    // Detailed List Results
                    ForEach(viewModel.lists, id: \.id) { list in
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text(list.name)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("\(list.voteCount) صوت")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: list.colorStart), Color(hex: list.colorEnd)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            )
                            
                            ForEach(viewModel.candidatesForList(list.name), id: \.id) { candidate in
                                HStack {
                                    Text(candidate.name)
                                        .font(.body)
                                        .foregroundColor(Color(hex: "2C3E50"))
                                    
                                    Spacer()
                                    
                                    Text("\(candidate.voteCount)")
                                        .font(.headline)
                                        .foregroundColor(Color(hex: "2ECC71"))
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 40)
                }
                .padding(.vertical, 20)
            }
            .background(Color(hex: "F5F7FA"))
            .navigationTitle("التحليلات")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        viewModel.logout()
                    }) {
                        Text("تسجيل خروج")
                            .foregroundColor(Color(hex: "E74C3C"))
                    }
                }
            }
        }
    }
    
    private func rankColor(_ index: Int) -> Color {
        switch index {
        case 0: return Color(hex: "F39C12") // Gold
        case 1: return Color(hex: "95A5A6") // Silver
        case 2: return Color(hex: "CD7F32") // Bronze
        default: return Color(hex: "3498DB")
        }
    }
}

struct SummaryCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(Color(hex: "2C3E50"))
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color(hex: "7F8C8D"))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    AnalyticsView()
        .modelContainer(for: [Voter.self, ElectionList.self, Candidate.self, Vote.self])
}
