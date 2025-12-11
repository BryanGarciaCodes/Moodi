//
//  OnboardingView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var hasCompletedOnboarding: Bool
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0.0
    @State private var titleOffset: CGFloat = 50
    @State private var buttonOpacity: Double = 0.0
    @State private var buttonScale: CGFloat = 0.8
    
    var body: some View {
        ZStack {
            // Gradient background matching Figma
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.6),
                    Color.purple.opacity(0.7),
                    Color.pink.opacity(0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Spacer()
                
                // Moodi Logo with Animation
                VStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 120, height: 120)
                            .offset(x: -15, y: 15)
                        
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.pink, Color.purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 120, height: 120)
                    }
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    
                    Text("Moodi")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                        .offset(y: titleOffset)
                        .opacity(logoOpacity)
                    
                    Text("Your Emotions, Your AI Companion")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.9))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .offset(y: titleOffset)
                        .opacity(logoOpacity)
                }
                
                Spacer()
                
                // Get Started Button with Animation
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        hasCompletedOnboarding = true
                    }
                }) {
                    HStack {
                        Text("Get Started")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                            .font(.title3)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color.blue, Color.cyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(15)
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
                .scaleEffect(buttonScale)
                .opacity(buttonOpacity)
            }
        }
        .onAppear {
            // Animate logo
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6).delay(0.2)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            
            // Animate title
            withAnimation(.easeOut(duration: 0.6).delay(0.5)) {
                titleOffset = 0
            }
            
            // Animate button
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.8)) {
                buttonScale = 1.0
                buttonOpacity = 1.0
            }
        }
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}
