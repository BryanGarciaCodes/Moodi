//
//  PlaylistView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct PlaylistView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isPlaying = false
    
    let recentPlaylists = [
        Playlist(title: "folklore", artist: "Taylor Swift", image: "music.note"),
        Playlist(title: "Future Nostalgia", artist: "Dua Lipa", image: "music.note"),
        Playlist(title: "After Hours", artist: "The Weeknd", image: "music.note")
    ]
    
    let popularPlaylists = [
        Playlist(title: "Blinding Lights", artist: "The Weeknd", image: "music.note"),
        Playlist(title: "10 Heartbreaking Songs", artist: "Various Artists", image: "music.note")
    ]
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.black,
                    Color.purple.opacity(0.5)
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
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Playlist")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .opacity(0)
                }
                .padding()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        // Now Playing Header
                        Text("Good afternoon")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                        Text("Jump back in")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        // Recent Playlists Grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                            ForEach(recentPlaylists) { playlist in
                                PlaylistCard(playlist: playlist)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Popular Playlists Section
                        Text("Popular playlists")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        
                        ForEach(popularPlaylists) { playlist in
                            HStack(spacing: 15) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 60, height: 60)
                                    .overlay(
                                        Image(systemName: "music.note")
                                            .foregroundColor(.white)
                                    )
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(playlist.title)
                                        .font(.body)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                    Text(playlist.artist)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Button(action: {}) {
                                    Image(systemName: "plus.circle")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 120)
                }
                
                Spacer()
            }
            
            // Bottom Player Bar
            VStack {
                Spacer()
                
                HStack(spacing: 15) {
                    Image(systemName: "music.note")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Your Library")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text("58 songs")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.black.opacity(0.9))
                )
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Playlist Model
struct Playlist: Identifiable {
    let id = UUID()
    let title: String
    let artist: String
    let image: String
}

// MARK: - Playlist Card Component
struct PlaylistCard: View {
    let playlist: Playlist
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 120)
                .overlay(
                    Image(systemName: playlist.image)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
            
            Text(playlist.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text(playlist.artist)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
        }
    }
}

#Preview {
    PlaylistView()
}
