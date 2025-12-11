//
//  Constants.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct AppConstants {
    // MARK: - Colors
    struct Colors {
        static let primaryPurple = Color(red: 0.5, green: 0.3, blue: 0.8)
        static let primaryPink = Color(red: 1.0, green: 0.4, blue: 0.6)
        static let primaryBlue = Color(red: 0.2, green: 0.5, blue: 0.9)
        
        static let backgroundGradient = LinearGradient(
            colors: [
                Color.blue.opacity(0.3),
                Color.purple.opacity(0.3)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let moodiGradient = LinearGradient(
            colors: [Color.pink, Color.purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // MARK: - Spacing
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    // MARK: - Corner Radius
    struct CornerRadius {
        static let small: CGFloat = 10
        static let medium: CGFloat = 15
        static let large: CGFloat = 20
        static let extraLarge: CGFloat = 30
    }
    
    // MARK: - Animation Durations
    struct Animation {
        static let fast: Double = 0.2
        static let normal: Double = 0.3
        static let slow: Double = 0.5
    }
    
    // MARK: - Font Sizes
    struct FontSize {
        static let small: CGFloat = 12
        static let body: CGFloat = 16
        static let title: CGFloat = 24
        static let largeTitle: CGFloat = 32
    }
}
