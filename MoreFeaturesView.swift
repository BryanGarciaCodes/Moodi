//
//  MoreFeaturesView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct MoreFeaturesView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.indigo.opacity(0.2),
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
                    
                    Text("More Features")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .opacity(0)
                }
                .padding()
                .background(Color.white.opacity(0.8))
                
                ScrollView {
                    VStack(spacing: 15) {
                        FeatureRow(icon: "map", title: "Location", color: .blue, destination: AnyView(LocationView()))
                        FeatureRow(icon: "scribble", title: "Draw", color: .orange, destination: AnyView(DrawView()))
                        FeatureRow(icon: "music.note", title: "Playlist", color: .pink, destination: AnyView(PlaylistView()))
                        FeatureRow(icon: "photo.on.rectangle", title: "Gallery", color: .purple, destination: AnyView(GalleryView()))
                        FeatureRow(icon: "camera", title: "Camera", color: .gray, destination: AnyView(CameraView()))
                        FeatureRow(icon: "safari", title: "Web Browser", color: .blue, destination: AnyView(WebView()))
                        FeatureRow(icon: "lock.shield", title: "Lock Screen", color: .indigo, destination: AnyView(LockScreenView()))
                        FeatureRow(icon: "bell", title: "Notifications", color: .red, destination: AnyView(NotificationBarView()))
                        FeatureRow(icon: "paintbrush", title: "Theme Preview", color: .green, destination: AnyView(ThemePreviewView()))
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Feature Row Component
struct FeatureRow: View {
    let icon: String
    let title: String
    let color: Color
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 15) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(color.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.title3)
                        .foregroundColor(color)
                }
                
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(15)
            .shadow(color: .black.opacity(0.05), radius: 5)
        }
    }
}

#Preview {
    NavigationView {
        MoreFeaturesView()
    }
}
