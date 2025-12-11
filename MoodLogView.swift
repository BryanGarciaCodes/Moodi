//
//  MoodLogView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct MoodLogView: View {
    @EnvironmentObject var viewModel: MoodViewModel  // ← Changed this line
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.slate.opacity(0.3),
                    Color.blue.opacity(0.2)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.indigo)
                    }
                    Spacer()
                    Text("Mood Log")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer()
                    // Invisible button for centering
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .opacity(0)
                }
                .padding()
                .background(Color.white.opacity(0.8))
                
                // Search Bar (placeholder)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    Text("Search")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
                .background(Color.white.opacity(0.6))
                .cornerRadius(15)
                .padding()
                
                // Mood Entries List
                ScrollView {
                    VStack(spacing: 15) {
                        if viewModel.moodEntries.isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "book.closed")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("No mood entries yet")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                Text("Start tracking your moods to see them here")
                                    .font(.subheadline)
                                    .foregroundColor(.gray.opacity(0.7))
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.top, 100)
                        } else {
                            ForEach(viewModel.moodEntries) { entry in
                                MoodLogCard(entry: entry)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Mood Log Card Component
struct MoodLogCard: View {
    let entry: MoodEntry
    
    var moodData: Mood? {
        Mood.allMoods.first(where: { $0.name == entry.mood })
    }
    
    var body: some View {
        HStack(spacing: 15) {
            // Mood Icon
            if let mood = moodData {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(mood.backgroundColor)
                        .frame(width: 60, height: 60)
                    
                    Text(mood.emoji)
                        .font(.system(size: 35))
                }
            }
            
            // Entry Details
            VStack(alignment: .leading, spacing: 5) {
                Text(entry.mood)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                HStack(spacing: 5) {
                    Image(systemName: "clock")
                        .font(.caption)
                    Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                    
                    if let location = entry.location {
                        Text("•")
                            .font(.caption)
                        Image(systemName: "location.fill")
                            .font(.caption)
                        Text(location)
                            .font(.caption)
                    }
                }
                .foregroundColor(.gray)
                
                if !entry.note.isEmpty {
                    Text(entry.note)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .padding(.top, 5)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

// Helper color extension for slate
extension Color {
    static let slate = Color(red: 0.4, green: 0.45, blue: 0.5)
}

#Preview {
    MoodLogView()
        .environmentObject(MoodViewModel())
}
