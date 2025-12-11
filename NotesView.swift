//
//  NotesView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct NotesView: View {
    @Environment(\.dismiss) var dismiss
    @State private var noteText = ""
    @State private var notes: [Note] = [
        Note(title: "Morning thoughts", content: "Feeling grateful today", date: Date())
    ]
    @State private var showingNewNote = false
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.2),
                    Color.purple.opacity(0.2)
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
                    
                    Text("Notes")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Moodi icon
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.pink, Color.purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 35, height: 35)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.8))
                
                // Notes Header
                HStack {
                    Text("Notes")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding()
                
                // Notes List
                ScrollView {
                    VStack(spacing: 15) {
                        if notes.isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "note.text")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("No notes yet")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                Text("Tap the + button to create your first note")
                                    .font(.subheadline)
                                    .foregroundColor(.gray.opacity(0.7))
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.top, 100)
                        } else {
                            ForEach(notes) { note in
                                NoteCard(note: note)
                            }
                        }
                    }
                    .padding()
                }
                
                // Bottom Text Input Area
                VStack(spacing: 0) {
                    Divider()
                    
                    HStack(alignment: .bottom, spacing: 12) {
                        TextEditor(text: $noteText)
                            .frame(minHeight: 40, maxHeight: 100)
                            .padding(8)
                            .background(Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        Button(action: {
                            // Voice input
                        }) {
                            Image(systemName: "mic.fill")
                                .font(.title2)
                                .foregroundColor(.purple)
                        }
                        .padding(.bottom, 8)
                    }
                    .padding()
                    .background(Color.white.opacity(0.95))
                }
            }
            
            // Floating Add Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        if !noteText.isEmpty {
                            notes.insert(Note(title: "New Note", content: noteText, date: Date()), at: 0)
                            noteText = ""
                        }
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.purple, Color.pink],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            )
                            .shadow(color: .purple.opacity(0.4), radius: 10)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 150)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Note Model
struct Note: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let date: Date
}

// MARK: - Note Card Component
struct NoteCard: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.title)
                .font(.headline)
            
            Text(note.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            HStack {
                Image(systemName: "clock")
                    .font(.caption)
                Text(note.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                Spacer()
            }
            .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

#Preview {
    NotesView()
}
