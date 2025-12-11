//
//  DashboardView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var viewModel: MoodViewModel
    @State private var userName = "Bryan"
    @State private var appearedCards: Set<Int> = []
    @State private var headerAppeared = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.3),
                        Color.purple.opacity(0.3)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Header
                        headerView
                            .opacity(headerAppeared ? 1 : 0)
                            .offset(y: headerAppeared ? 0 : -20)
                        
                        // Main Grid - 3x2 layout
                        mainGridView
                        
                        // Notes Card - Wide button
                        notesCard
                        
                        // More Features Button
                        moreFeaturesButton
                        
                        // Bottom Moodi Icon
                        bottomMoodiIcon
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            animateAppearance()
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        HStack {
            Spacer()
            
            Text("Hello \(userName)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            // Profile icon
            NavigationLink(destination: AccountView()) {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.pink, Color.purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                        .font(.title3)
                }
                .shadow(color: .purple.opacity(0.3), radius: 5, x: 0, y: 3)
            }
            .simultaneousGesture(TapGesture().onEnded {
                HapticManager.shared.lightImpact()
            })
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
    
    // MARK: - Main Grid View
    private var mainGridView: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 20) {
            DashboardCardLink(
                destination: AnyView(ChatView()),
                icon: "message.fill",
                title: "Chat",
                color: .white,
                index: 0,
                isAppeared: appearedCards.contains(0)
            )
            
            DashboardCardLink(
                destination: AnyView(HomeView()),
                icon: "brain.head.profile",
                title: "Moodi AI",
                color: .purple,
                index: 1,
                isAppeared: appearedCards.contains(1)
            )
            
            DashboardCardLink(
                destination: AnyView(MoodLogView()),
                icon: "book.fill",
                title: "Logs",
                color: .white,
                index: 2,
                isAppeared: appearedCards.contains(2)
            )
            
            DashboardCardLink(
                destination: AnyView(SearchView()),
                icon: "magnifyingglass",
                title: "Search",
                color: .white,
                index: 3,
                isAppeared: appearedCards.contains(3)
            )
            
            DashboardCardLink(
                destination: AnyView(AccountView()),
                icon: "person.fill",
                title: "Account",
                color: .white,
                index: 4,
                isAppeared: appearedCards.contains(4)
            )
            
            DashboardCardLink(
                destination: AnyView(SettingsView()),
                icon: "gearshape.fill",
                title: "Settings",
                color: .white,
                index: 5,
                isAppeared: appearedCards.contains(5)
            )
        }
        .padding(.horizontal)
    }
    
    // MARK: - Notes Card
    private var notesCard: some View {
        NavigationLink(destination: NotesView()) {
            DashboardCard(icon: "note.text", title: "Notes", color: .white, isWide: true)
                .padding(.horizontal)
        }
        .simultaneousGesture(TapGesture().onEnded {
            HapticManager.shared.lightImpact()
        })
        .opacity(appearedCards.contains(6) ? 1 : 0)
        .scaleEffect(appearedCards.contains(6) ? 1 : 0.8)
        .offset(y: appearedCards.contains(6) ? 0 : 20)
    }
    
    // MARK: - More Features Button
    private var moreFeaturesButton: some View {
        NavigationLink(destination: MoreFeaturesView()) {
            HStack(spacing: 12) {
                Image(systemName: "square.grid.2x2")
                    .font(.title3)
                    .foregroundColor(.indigo)
                Text("More Features")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.indigo)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.indigo.opacity(0.6))
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.05), radius: 5)
        }
        .simultaneousGesture(TapGesture().onEnded {
            HapticManager.shared.lightImpact()
        })
        .padding(.horizontal)
        .opacity(appearedCards.contains(7) ? 1 : 0)
        .scaleEffect(appearedCards.contains(7) ? 1 : 0.8)
        .offset(y: appearedCards.contains(7) ? 0 : 20)
    }
    
    // MARK: - Bottom Moodi Icon
    private var bottomMoodiIcon: some View {
        NavigationLink(destination: HomeView()) {
            ZStack {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.pink, Color.purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 80, height: 80)
                    .shadow(color: .purple.opacity(0.4), radius: 10, x: 0, y: 5)
                
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
            }
            .pulseAnimation(duration: 2.0)
        }
        .simultaneousGesture(TapGesture().onEnded {
            HapticManager.shared.mediumImpact()
        })
        .padding(.vertical, 20)
        .padding(.bottom, 30)
        .opacity(appearedCards.contains(8) ? 1 : 0)
        .scaleEffect(appearedCards.contains(8) ? 1 : 0.5)
    }
    
    // MARK: - Animation Logic
    private func animateAppearance() {
        // Animate header
        withAnimation(.easeOut(duration: 0.5)) {
            headerAppeared = true
        }
        
        // Animate cards with stagger
        for index in 0...8 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.1) {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                    appearedCards.insert(index)
                }
            }
        }
    }
}

// MARK: - Dashboard Card Link Component
struct DashboardCardLink: View {
    let destination: AnyView
    let icon: String
    let title: String
    let color: Color
    let index: Int
    let isAppeared: Bool
    
    @State private var isPressed = false
    
    var body: some View {
        NavigationLink(destination: destination) {
            DashboardCard(icon: icon, title: title, color: color)
                .scaleEffect(isPressed ? 0.9 : 1.0)
                .opacity(isAppeared ? 1 : 0)
                .scaleEffect(isAppeared ? 1 : 0.8)
                .offset(y: isAppeared ? 0 : 20)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isPressed = true
                    }
                    HapticManager.shared.lightImpact()
                }
                .onEnded { _ in
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        isPressed = false
                    }
                }
        )
    }
}

// MARK: - Dashboard Card Component
struct DashboardCard: View {
    let icon: String
    let title: String
    let color: Color
    var isWide: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: isWide ? 35 : 30))
                .foregroundColor(color == .white ? .black : .white)
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(color == .white ? .black : .white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: isWide ? 100 : 110)
        .background {
            if color == .white {
                Color.white.opacity(0.9)
            } else {
                LinearGradient(
                    colors: [Color.purple, Color.pink],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            }
        }
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    DashboardView()
        .environmentObject(MoodViewModel())
}
