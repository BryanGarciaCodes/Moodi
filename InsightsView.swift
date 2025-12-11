//
//  InsightsView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct InsightsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MoodViewModel
    
    var body: some View {
        ZStack {
            backgroundGradient
            mainContent
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Background
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color.purple.opacity(0.2),
                Color.indigo.opacity(0.2)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
    
    // MARK: - Main Content
    private var mainContent: some View {
        VStack(spacing: 0) {
            headerView
            contentScrollView
        }
    }
    
    // MARK: - Header
    private var headerView: some View {
        HStack {
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.indigo)
            }
            
            Spacer()
            
            Text("Your Insights")
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Image(systemName: "chevron.left")
                .font(.title2)
                .opacity(0)
        }
        .padding()
        .background(Color.white.opacity(0.8))
    }
    
    // MARK: - Scroll Content
    private var contentScrollView: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerIconView
                
                if viewModel.moodEntries.isEmpty {
                    emptyStateView
                } else {
                    mostCommonMoodView
                    moodDistributionView
                    aiInsightView
                }
                
                weekSummaryView
            }
        }
    }
    
    // MARK: - Header Icon
    private var headerIconView: some View {
        VStack(spacing: 10) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.system(size: 50))
                .foregroundColor(.indigo)
            
            Text("Patterns in your emotional wellness")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.top, 20)
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "chart.bar")
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
            Text("No insights yet")
                .font(.title3)
                .foregroundColor(.gray)
            Text("Start tracking your moods to see insights")
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.top, 100)
    }
    
    // MARK: - Most Common Mood
    @ViewBuilder
    private var mostCommonMoodView: some View {
        if let mostCommon = viewModel.getMostCommonMood(),
           let mood = Mood.allMoods.first(where: { $0.name == mostCommon }) {
            VStack(alignment: .leading, spacing: 15) {
                Text("Most Common Mood")
                    .font(.headline)
                
                HStack(spacing: 15) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(mood.backgroundColor)
                            .frame(width: 70, height: 70)
                        
                        Text(mood.emoji)
                            .font(.system(size: 40))
                    }
                    
                    VStack(alignment: .leading) {
                        Text(mood.name)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        let count = viewModel.getMoodCounts()[mostCommon] ?? 0
                        Text("\(count) times logged")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(20)
            .padding(.horizontal)
        }
    }
    
    // MARK: - Mood Distribution
    private var moodDistributionView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Mood Distribution")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(Array(viewModel.getMoodCounts().keys.sorted()), id: \.self) { moodName in
                if let count = viewModel.getMoodCounts()[moodName],
                   let mood = Mood.allMoods.first(where: { $0.name == moodName }) {
                    MoodDistributionBar(
                        mood: mood,
                        count: count,
                        total: viewModel.moodEntries.count
                    )
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    // MARK: - AI Insight
    private var aiInsightView: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "brain.head.profile")
                    .font(.title2)
                    .foregroundColor(.white)
                Text("AI Insight")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            
            Text("You've been consistently tracking your moods! Based on your patterns, you tend to feel most energetic in the mornings. Consider scheduling important tasks during these peak hours.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.indigo, Color.purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
        .padding(.horizontal)
    }
    
    // MARK: - Week Summary
    private var weekSummaryView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("This Week")
                .font(.headline)
            
            HStack(spacing: 10) {
                ForEach(0..<7, id: \.self) { day in
                    weekDayView(day: day)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
    
    private func weekDayView(day: Int) -> some View {
        VStack(spacing: 5) {
            let days = ["M", "T", "W", "T", "F", "S", "S"]
            Text(days[day])
                .font(.caption2)
                .foregroundColor(.gray)
            
            Circle()
                .fill(day < 4 ? Color.green : Color.gray.opacity(0.3))
                .frame(width: 30, height: 30)
        }
    }
}

// MARK: - Mood Distribution Bar
struct MoodDistributionBar: View {
    let mood: Mood
    let count: Int
    let total: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(mood.emoji)
                    .font(.title3)
                Text(mood.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text("\(count) entries")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            progressBar
        }
        .padding(.horizontal)
    }
    
    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 8)
                
                if total > 0 {
                    let percentage = Double(count) / Double(total)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(mood.color)
                        .frame(width: geometry.size.width * percentage, height: 8)
                }
            }
        }
        .frame(height: 8)
    }
}

#Preview {
    NavigationView {
        InsightsView()
            .environmentObject(MoodViewModel())
    }
}
