//
//  MoodViewModel.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

class MoodViewModel: ObservableObject {
    @Published var moodEntries: [MoodEntry] = []
    @Published var selectedMood: Mood?
    
    init() {
        // Load sample data
        loadSampleData()
    }
    
    func addMoodEntry(mood: String, note: String, location: String? = nil) {
        let newEntry = MoodEntry(mood: mood, note: note, location: location)
        moodEntries.insert(newEntry, at: 0)
        saveMoodEntries()
    }
    
    func getMoodCounts() -> [String: Int] {
        var counts: [String: Int] = [:]
        for entry in moodEntries {
            counts[entry.mood, default: 0] += 1
        }
        return counts
    }
    
    func getMostCommonMood() -> String? {
        let counts = getMoodCounts()
        return counts.max(by: { $0.value < $1.value })?.key
    }
    
    private func saveMoodEntries() {
        if let encoded = try? JSONEncoder().encode(moodEntries) {
            UserDefaults.standard.set(encoded, forKey: "moodEntries")
        }
    }
    
    private func loadSampleData() {
        // Sample entries for demo
        moodEntries = [
            MoodEntry(mood: "Happy", date: Date().addingTimeInterval(-86400), note: "Great morning walk", location: "Park"),
            MoodEntry(mood: "Calm", date: Date().addingTimeInterval(-172800), note: "Meditation session", location: "Home"),
            MoodEntry(mood: "Energetic", date: Date().addingTimeInterval(-259200), note: "Workout completed", location: "Gym")
        ]
    }
}
