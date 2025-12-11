//
//  MoodEntry.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct MoodEntry: Identifiable, Codable {
    let id: UUID
    let mood: String  // mood name like "Happy", "Sad"
    let date: Date
    let note: String
    let location: String?
    
    init(id: UUID = UUID(), mood: String, date: Date = Date(), note: String = "", location: String? = nil) {
        self.id = id
        self.mood = mood
        self.date = date
        self.note = note
        self.location = location
    }
}
