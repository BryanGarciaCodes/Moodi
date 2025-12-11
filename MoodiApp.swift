//
//  MoodiApp.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

@main
struct MoodiApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @StateObject private var moodViewModel = MoodViewModel()
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                DashboardView()
                    .environmentObject(moodViewModel)
            } else {
                OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
                    .environmentObject(moodViewModel)
            }
        }
    }
}
