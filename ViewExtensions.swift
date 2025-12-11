//
//  ViewExtensions.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

// MARK: - Smooth Card Appearance
extension View {
    func cardAppearance() -> some View {
        self
            .transition(.scale.combined(with: .opacity))
            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: UUID())
    }
    
    func smoothScale() -> some View {
        self
            .scaleEffect(0.95)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: UUID())
    }
}

// MARK: - Shimmer Effect
struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0),
                        Color.white.opacity(0.3),
                        Color.white.opacity(0)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: phase)
                .mask(content)
            )
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false)
                ) {
                    phase = 400
                }
            }
    }
}

extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerEffect())
    }
}

// MARK: - Bounce Animation
extension View {
    func bounceAnimation() -> some View {
        self.modifier(BounceAnimationModifier())
    }
}

struct BounceAnimationModifier: ViewModifier {
    @State private var scale: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                withAnimation(
                    Animation.spring(response: 0.3, dampingFraction: 0.5)
                        .repeatForever(autoreverses: true)
                ) {
                    scale = 1.1
                }
            }
    }
}

// MARK: - Pulse Animation
extension View {
    func pulseAnimation(duration: Double = 1.0) -> some View {
        self.modifier(PulseAnimationModifier(duration: duration))
    }
}

struct PulseAnimationModifier: ViewModifier {
    let duration: Double
    @State private var scale: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                withAnimation(
                    Animation.easeInOut(duration: duration)
                        .repeatForever(autoreverses: true)
                ) {
                    scale = 1.05
                }
            }
    }
}

// MARK: - Slide In Animation
extension View {
    func slideInFromBottom(delay: Double = 0) -> some View {
        self.modifier(SlideInFromBottomModifier(delay: delay))
    }
}

struct SlideInFromBottomModifier: ViewModifier {
    let delay: Double
    @State private var offset: CGFloat = 100
    @State private var opacity: Double = 0
    
    func body(content: Content) -> some View {
        content
            .offset(y: offset)
            .opacity(opacity)
            .onAppear {
                withAnimation(
                    .spring(response: 0.6, dampingFraction: 0.8)
                    .delay(delay)
                ) {
                    offset = 0
                    opacity = 1
                }
            }
    }
}

// MARK: - Gradient Text
extension View {
    func gradientForeground(colors: [Color]) -> some View {
        self.overlay(
            LinearGradient(
                colors: colors,
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .mask(self)
    }
}

// MARK: - Card Style
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.white.opacity(0.9))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardStyle())
    }
}

// MARK: - Glassmorphism Effect
struct GlassmorphismStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.2))
                    .blur(radius: 10)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
    }
}

extension View {
    func glassmorphism() -> some View {
        self.modifier(GlassmorphismStyle())
    }
}
