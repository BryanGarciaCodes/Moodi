//
//  Mood.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct Mood: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let color: Color
    let backgroundColor: Color
    let gradientColors: [Color]
    
    // AI suggestions for each mood
    var musicSuggestions: [String]
    var activitySuggestions: [String]
    var giftSuggestions: [String]
    var placeSuggestions: [String]
}

// Predefined moods with AI suggestions
extension Mood {
    static let allMoods: [Mood] = [
        Mood(
            name: "Happy",
            emoji: "😊",
            color: .yellow,
            backgroundColor: Color.yellow.opacity(0.15),
            gradientColors: [Color.yellow.opacity(0.6), Color.orange.opacity(0.4)],
            musicSuggestions: ["Upbeat Pop Playlist", "Feel-Good Classics", "Dance Party Mix"],
            activitySuggestions: ["Share your joy with friends", "Try something new today", "Capture this moment in photos"],
            giftSuggestions: ["Colorful flowers", "A celebration cake", "Fun board games"],
            placeSuggestions: ["Local festival", "Amusement park", "Favorite restaurant"]
        ),
        
        Mood(
            name: "Calm",
            emoji: "☁️",
            color: .blue,
            backgroundColor: Color.blue.opacity(0.15),
            gradientColors: [Color.blue.opacity(0.4), Color.cyan.opacity(0.3)],
            musicSuggestions: ["Ambient Soundscapes", "Classical Piano", "Nature Sounds"],
            activitySuggestions: ["Meditation session", "Read a good book", "Gentle yoga flow"],
            giftSuggestions: ["Aromatherapy candles", "Cozy blanket", "Herbal tea set"],
            placeSuggestions: ["Botanical garden", "Quiet beach", "Art museum"]
        ),
        
        Mood(
            name: "Sad",
            emoji: "😢",
            color: .indigo,
            backgroundColor: Color.indigo.opacity(0.15),
            gradientColors: [Color.blue.opacity(0.5), Color.indigo.opacity(0.4)],
            musicSuggestions: ["Comforting Melodies", "Emotional Ballads", "Rain Sounds"],
            activitySuggestions: ["Journal your feelings", "Watch a comfort movie", "Call a loved one"],
            giftSuggestions: ["Self-care package", "Warm comfort food", "Soft plush toy"],
            placeSuggestions: ["Cozy café", "Home sanctuary", "Quiet library"]
        ),
        
        Mood(
            name: "Angry",
            emoji: "⚡",
            color: .red,
            backgroundColor: Color.red.opacity(0.15),
            gradientColors: [Color.red.opacity(0.5), Color.orange.opacity(0.5)],
            musicSuggestions: ["Intense Rock", "Workout Beats", "Drum Therapy"],
            activitySuggestions: ["High-intensity workout", "Punch a pillow", "Write it all out"],
            giftSuggestions: ["Stress ball", "Boxing gloves", "Adult coloring book"],
            placeSuggestions: ["Gym", "Rage room", "Nature trail for a run"]
        ),
        
        Mood(
            name: "Energetic",
            emoji: "☀️",
            color: .orange,
            backgroundColor: Color.orange.opacity(0.15),
            gradientColors: [Color.orange.opacity(0.5), Color.pink.opacity(0.4)],
            musicSuggestions: ["EDM Hits", "Workout Pump", "Rock Anthems"],
            activitySuggestions: ["Go for a run", "Start a new project", "Clean and organize"],
            giftSuggestions: ["Sports equipment", "Energy drink variety pack", "Fitness tracker"],
            placeSuggestions: ["Climbing gym", "Dance studio", "Adventure park"]
        ),
        
        Mood(
            name: "Tired",
            emoji: "🌙",
            color: .purple,
            backgroundColor: Color.purple.opacity(0.15),
            gradientColors: [Color.purple.opacity(0.4), Color.indigo.opacity(0.4)],
            musicSuggestions: ["Sleep Sounds", "Lo-fi Beats", "Gentle Lullabies"],
            activitySuggestions: ["Take a power nap", "Light stretching", "Early bedtime routine"],
            giftSuggestions: ["Sleep mask", "Comfortable pajamas", "Lavender pillow spray"],
            placeSuggestions: ["Home bed", "Spa", "Quiet park bench"]
        ),
        
        Mood(
            name: "Neutral",
            emoji: "😐",
            color: .gray,
            backgroundColor: Color.gray.opacity(0.15),
            gradientColors: [Color.gray.opacity(0.4), Color.gray.opacity(0.5)],
            musicSuggestions: ["Mixed Genres", "Discover Weekly", "Chill Vibes"],
            activitySuggestions: ["Explore something new", "Casual walk", "Browse a bookstore"],
            giftSuggestions: ["Something unexpected", "Gift card", "Mystery box"],
            placeSuggestions: ["New café", "Local market", "City exploration"]
        ),
        
        Mood(
            name: "Anxious",
            emoji: "💗",
            color: .pink,
            backgroundColor: Color.pink.opacity(0.15),
            gradientColors: [Color.pink.opacity(0.4), Color.purple.opacity(0.4)],
            musicSuggestions: ["Calming Piano", "Breathing Exercises", "Soft Acoustic"],
            activitySuggestions: ["Deep breathing exercises", "Grounding techniques", "Talk to someone you trust"],
            giftSuggestions: ["Weighted blanket", "Anxiety journal", "Fidget tools"],
            placeSuggestions: ["Therapist office", "Safe quiet space", "Nature walk"]
        )
    ]
}
