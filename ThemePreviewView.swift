//
//  ThemePreviewView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct ThemePreviewView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTheme = "Dark"
    
    let themes = [
        Theme(name: "Happy", colors: [Color.yellow, Color.orange]),
        Theme(name: "Sad", colors: [Color.blue, Color.indigo]),
        Theme(name: "Angry", colors: [Color.red, Color.orange]),
        Theme(name: "Calm", colors: [Color.blue, Color.cyan]),
        Theme(name: "Energetic", colors: [Color.orange, Color.pink]),
        Theme(name: "Dark", colors: [Color.black, Color.gray])
    ]
    
    var body: some View {
        ZStack {
            // Dynamic background based on selected theme
            if let theme = themes.first(where: { $0.name == selectedTheme }) {
                LinearGradient(
                    colors: theme.colors,
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                // Animated Elements (Decorative)
                ZStack {
                    ForEach(0..<6, id: \.self) { index in
                        Circle()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: CGFloat.random(in: 40...80))
                            .offset(
                                x: CGFloat.random(in: -150...150),
                                y: CGFloat.random(in: -200...200)
                            )
                    }
                }
                
                Spacer()
                
                // Action Buttons
                HStack(spacing: 20) {
                    Button(action: { dismiss() }) {
                        Text("Change")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 120)
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(15)
                    }
                    
                    Button(action: {
                        // Update theme
                    }) {
                        Text("Update")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 120)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(15)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Theme Model
struct Theme {
    let name: String
    let colors: [Color]
}

#Preview {
    ThemePreviewView()
}
