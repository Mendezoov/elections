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
    @State private var typedText = ""
    @State private var showButton = false
    @Binding var hasSeenOnboarding: Bool
    
    private let fullText = "لجنة الانتخابات المحلية بلدية كفر الديك ٢٠٢٦"
    
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
                VStack(spacing: 20) {
                    Text("مرحباً بكم في")
                        .font(.system(size: 22, weight: .medium, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.white, .white.opacity(0.9)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                    
                    // Typing animation text
                    ZStack {
                        // Background glow effect
                        Text(typedText)
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .blur(radius: 10)
                            .opacity(0.5)
                        
                        // Main text with gradient
                        Text(typedText)
                            .font(.system(size: 26, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [
                                        Color(hex: "FFD700"),
                                        Color(hex: "FFA500"),
                                        Color(hex: "FFD700")
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .frame(minHeight: 100)
                            .minimumScaleFactor(0.5)
                            .lineLimit(3)
                    }
                    
                    // Cursor effect
                    if typedText.count < fullText.count {
                        Text("|")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color(hex: "FFD700"))
                            .opacity(textOpacity)
                    }
                }
                .opacity(textOpacity)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Powered by text
                HStack(spacing: 4) {
                    Text("powered")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .italic()
                    Text("by Mendez developer")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                }
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(hex: "FFD700").opacity(0.9),
                            Color(hex: "FFA500").opacity(0.8)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                .opacity(showButton ? 1 : 0)
                .animation(.easeIn(duration: 0.6).delay(0.2), value: showButton)
                
                // Continue button
                Button(action: {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        hasSeenOnboarding = true
                    }
                }) {
                    Text("متابعة")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(
                            LinearGradient(
                                colors: [Color(hex: "2ECC71"), Color(hex: "27AE60")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                        )
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
                .opacity(showButton ? 1 : 0)
                .scaleEffect(showButton ? 1 : 0.8)
            }
        }
        .onAppear {
            // Animate logo
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.2)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            
            // Fade in welcome text
            withAnimation(.easeIn(duration: 0.6).delay(0.8)) {
                textOpacity = 1.0
            }
            
            // Start typing animation after welcome text appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                startTypingAnimation()
            }
            
            // Show button after typing completes
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4 + Double(fullText.count) * 0.05 + 0.5) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    showButton = true
                }
            }
        }
    }
    
    private func startTypingAnimation() {
        typedText = ""
        
        for (index, character) in fullText.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                typedText.append(character)
                
                // Add a subtle haptic feedback for each character (optional)
                #if os(iOS)
                let impactLight = UIImpactFeedbackGenerator(style: .light)
                if index % 3 == 0 { // Only every 3rd character to not overwhelm
                    impactLight.impactOccurred(intensity: 0.3)
                }
                #endif
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
