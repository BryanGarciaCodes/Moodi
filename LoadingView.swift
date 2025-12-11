//
//  LoadingView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ZStack {
                    Circle()
                        .stroke(Color.purple.opacity(0.3), lineWidth: 4)
                        .frame(width: 60, height: 60)
                    
                    Circle()
                        .trim(from: 0, to: 0.7)
                        .stroke(
                            LinearGradient(
                                colors: [Color.purple, Color.pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            style: StrokeStyle(lineWidth: 4, lineCap: .round)
                        )
                        .frame(width: 60, height: 60)
                        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                        .animation(
                            Animation.linear(duration: 1)
                                .repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                }
                
                Text("Loading...")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.95))
            )
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Skeleton Loading Card
struct SkeletonLoadingCard: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 100)
                .shimmer()
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 20)
                .shimmer()
            
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 150, height: 15)
                .shimmer()
        }
        .padding()
        .cardStyle()
    }
}

// MARK: - Success Checkmark Animation
struct SuccessCheckmark: View {
    @State private var trimEnd: CGFloat = 0
    @State private var scale: CGFloat = 0.5
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.green, lineWidth: 3)
                .frame(width: 80, height: 80)
                .scaleEffect(scale)
                .opacity(scale)
            
            Path { path in
                path.move(to: CGPoint(x: 30, y: 50))
                path.addLine(to: CGPoint(x: 45, y: 65))
                path.addLine(to: CGPoint(x: 70, y: 35))
            }
            .trim(from: 0, to: trimEnd)
            .stroke(Color.green, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(rotation))
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                scale = 1.0
            }
            
            withAnimation(.easeOut(duration: 0.5).delay(0.2)) {
                trimEnd = 1.0
            }
            
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6).delay(0.1)) {
                rotation = 360
            }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        LoadingView()
        SkeletonLoadingCard()
        SuccessCheckmark()
    }
}
