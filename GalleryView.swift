//
//  GalleryView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct GalleryView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTab = "Albums"
    @State private var selectedImages: Set<UUID> = []
    
    let tabs = ["Cancel", "Albums", "Select"]
    let mockImages = Array(repeating: GalleryImage(), count: 12)
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.purple.opacity(0.3),
                    Color.pink.opacity(0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Tabs
                HStack(spacing: 0) {
                    ForEach(tabs, id: \.self) { tab in
                        Button(action: {
                            if tab == "Cancel" {
                                dismiss()
                            } else {
                                selectedTab = tab
                            }
                        }) {
                            Text(tab)
                                .font(.body)
                                .fontWeight(selectedTab == tab ? .semibold : .regular)
                                .foregroundColor(tab == "Select" ? .purple : .primary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                        }
                    }
                }
                .background(Color.white.opacity(0.9))
                
                // Gallery Grid
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 2),
                        GridItem(.flexible(), spacing: 2),
                        GridItem(.flexible(), spacing: 2)
                    ], spacing: 2) {
                        ForEach(mockImages) { image in
                            GalleryImageView(
                                image: image,
                                isSelected: selectedImages.contains(image.id)
                            )
                            .onTapGesture {
                                if selectedImages.contains(image.id) {
                                    selectedImages.remove(image.id)
                                } else {
                                    selectedImages.insert(image.id)
                                }
                            }
                        }
                    }
                }
                
                // Submit Button
                Button(action: {
                    // Submit selected images
                }) {
                    Text("Submit")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color.purple, Color.pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(15)
                }
                .padding()
                .background(Color.white.opacity(0.95))
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Gallery Image Model
struct GalleryImage: Identifiable {
    let id = UUID()
}

// MARK: - Gallery Image View
struct GalleryImageView: View {
    let image: GalleryImage
    let isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Random gradient as placeholder
            LinearGradient(
                colors: [
                    Color.random(),
                    Color.random()
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .aspectRatio(1, contentMode: .fill)
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(8)
            }
        }
    }
}

// Helper extension for random colors
extension Color {
    static func random() -> Color {
        Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}

#Preview {
    GalleryView()
}
