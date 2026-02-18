//
//  OnboardingView.swift
//  elections
//
//  Created by Mendez on 2/18/26.
//

import SwiftUI

struct OnboardingView: View {
    @State private var showContent = false
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0
    @State private var textOpacity: Double = 0
    @Binding var hasSeenOnboarding: Bool
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                colors: [Color(hex: "1e3c72"), Color(hex: "2a5298"), Color(hex: "7e8ba3")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Logo
                Image("pslogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                
                // Welcome text
                VStack(spacing: 16) {
                    Text("مرحباً بكم في")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    
                    Text("لجنة الانتخابات المحلية ٢٠٢٦")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .opacity(textOpacity)
                
                Spacer()
                
                // Continue button
                Button(action: {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        hasSeenOnboarding = true
                    }
                }) {
                    Text("متابعة")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(
                            LinearGradient(
                                colors: [Color(hex: "2ECC71"), Color(hex: "27AE60")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
                .opacity(textOpacity)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.2)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            
            withAnimation(.easeIn(duration: 0.8).delay(0.8)) {
                textOpacity = 1.0
            }
        }
    }
}

// Helper extension for hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    OnboardingView(hasSeenOnboarding: .constant(false))
}
