//
//  HomeView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: MoodViewModel
    @State private var selectedMood: Mood?
    @State private var showMoodDetail = false
    @State private var selectedMoodAnimation: UUID?
    @State private var appearedCards: Set<UUID> = []
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.indigo.opacity(0.1),
                    Color.purple.opacity(0.1),
                    Color.pink.opacity(0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                headerView
                    .slideInFromBottom(delay: 0.1)
                
                // Mood Selection Card
                moodSelectionCard
                    .slideInFromBottom(delay: 0.2)
                
                // Navigation Buttons
                navigationButtons
                    .slideInFromBottom(delay: 0.3)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showMoodDetail) {
            if let mood = selectedMood {
                MoodDetailView(mood: mood)
            }
        }
        .onAppear {
            // Trigger card animations
            for mood in Mood.allMoods {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(Mood.allMoods.firstIndex(where: { $0.id == mood.id }) ?? 0) * 0.05) {
                    withAnimation {
                        appearedCards.insert(mood.id)
                    }
                }
            }
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        VStack(spacing: 5) {
            HStack {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 40))
                    .foregroundColor(.indigo)
                Text("MOODI")
                    .font(.system(size: 40, weight: .bold))
                    .gradientForeground(colors: [.indigo, .purple])
            }
            Text("Your AI Mood Companion")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.top, 40)
    }
    
    // MARK: - Mood Selection Card
    private var moodSelectionCard: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("How are you feeling today?")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 15
            ) {
                ForEach(Mood.allMoods) { mood in
                    MoodButton(mood: mood, isAppeared: appearedCards.contains(mood.id)) {
                        // Haptic feedback
                        HapticManager.shared.mediumImpact()
                        
                        // Animation state
                        selectedMoodAnimation = mood.id
                        
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedMood = mood
                        }
                        
                        // Delay sheet presentation for smooth animation
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            showMoodDetail = true
                            selectedMoodAnimation = nil
                        }
                    }
                    .scaleEffect(selectedMoodAnimation == mood.id ? 0.9 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selectedMoodAnimation)
                }
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(30)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        .padding()
    }
    
    // MARK: - Navigation Buttons
    private var navigationButtons: some View {
        HStack(spacing: 15) {
            NavigationLink(destination: MoodLogView()) {
                NavigationButton(
                    icon: "calendar",
                    title: "Mood Log",
                    color: .indigo
                )
            }
            .simultaneousGesture(TapGesture().onEnded {
                HapticManager.shared.lightImpact()
            })
            
            NavigationLink(destination: InsightsView()) {
                NavigationButton(
                    icon: "chart.line.uptrend.xyaxis",
                    title: "Insights",
                    color: .purple
                )
            }
            .simultaneousGesture(TapGesture().onEnded {
                HapticManager.shared.lightImpact()
            })
        }
        .padding(.horizontal)
    }
}

// MARK: - Mood Button Component
struct MoodButton: View {
    let mood: Mood
    let isAppeared: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
                action()
            }
        }) {
            VStack(spacing: 8) {
                Text(mood.emoji)
                    .font(.system(size: 35))
                Text(mood.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(mood.backgroundColor)
            .cornerRadius(20)
            .shadow(color: mood.color.opacity(0.3), radius: isPressed ? 2 : 8, x: 0, y: isPressed ? 2 : 4)
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .opacity(isAppeared ? 1.0 : 0.0)
            .offset(y: isAppeared ? 0 : 20)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Navigation Button Component
struct NavigationButton: View {
    let icon: String
    let title: String
    let color: Color
    
    @State private var isPressed = false
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: isPressed ? 2 : 8, x: 0, y: isPressed ? 2 : 4)
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = pressing
            }
        }, perform: {})
    }
}

#Preview {
    NavigationView {
        HomeView()
            .environmentObject(MoodViewModel())
    }
}
