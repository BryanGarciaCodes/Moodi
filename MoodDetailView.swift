//
//  MoodDetailView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct MoodDetailView: View {
    let mood: Mood
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MoodViewModel  // ← Changed this line
    @State private var note: String = ""
    @State private var showingSaveConfirmation = false
    
    var body: some View {
        ZStack {
            // Dynamic gradient background based on mood
            LinearGradient(
                colors: mood.gradientColors,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header with back button
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    // Mood Icon and Title
                    VStack(spacing: 15) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: 120, height: 120)
                            
                            Text(mood.emoji)
                                .font(.system(size: 70))
                        }
                        
                        Text("Feeling \(mood.name)")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Let's make the most of this moment")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(.top, 20)
                    
                    // Music Suggestions
                    SuggestionCard(
                        icon: "music.note",
                        title: "Music for You",
                        items: mood.musicSuggestions,
                        iconColor: .indigo
                    )
                    
                    // Activity Suggestions
                    SuggestionCard(
                        icon: "figure.walk",
                        title: "Suggested Activities",
                        items: mood.activitySuggestions,
                        iconColor: .purple
                    )
                    
                    // Gift Suggestions
                    SuggestionCard(
                        icon: "gift.fill",
                        title: "Treat Yourself",
                        items: mood.giftSuggestions,
                        iconColor: .pink
                    )
                    
                    // Place Suggestions
                    SuggestionCard(
                        icon: "map.fill",
                        title: "Places to Go",
                        items: mood.placeSuggestions,
                        iconColor: .green
                    )
                    
                    // Note Input
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Add a Note (Optional)")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        TextEditor(text: $note)
                            .frame(height: 100)
                            .padding(10)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
                            )
                    }
                    .padding(.horizontal)
                    
                    // Save Button
                    Button(action: {
                        viewModel.addMoodEntry(mood: mood.name, note: note)
                        showingSaveConfirmation = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dismiss()
                        }
                    }) {
                        Text("Save to Mood Log")
                            .font(.headline)
                            .foregroundColor(mood.color)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
        .overlay(
            Group {
                if showingSaveConfirmation {
                    VStack {
                        Spacer()
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Saved to Mood Log!")
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(radius: 10)
                        .padding(.bottom, 50)
                    }
                    .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

// MARK: - Suggestion Card Component
struct SuggestionCard: View {
    let icon: String
    let title: String
    let items: [String]
    let iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.title3)
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            VStack(spacing: 10) {
                ForEach(items, id: \.self) { item in
                    HStack {
                        Text("•")
                            .foregroundColor(iconColor)
                            .fontWeight(.bold)
                        Text(item)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.95))
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.1), radius: 10)
        .padding(.horizontal)
    }
}

#Preview {
    MoodDetailView(mood: Mood.allMoods[0])
        .environmentObject(MoodViewModel())
}
