//
//  WebView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct WebView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = "ways to calm down and deal with sadness and ange"
    @State private var selectedCategory = "Shopping"
    
    let categories = ["All", "Shopping", "Videos", "News", "Images"]
    
    let webResults = [
        WebResult(
            title: "Mindful Steps: Managing Difficult Emotions",
            description: "Techniques for coping, anger, anxiety and sadness through mindfulness and CBT exercises.",
            url: "mindfulsteps.com",
            icon: "lightbulb.fill",
            color: .orange
        ),
        WebResult(
            title: "10 Healthy Ways to Express Anger",
            description: "Discover safe and constructive ways to process difficult emotions",
            url: "emotionalwellness.com",
            icon: "heart.fill",
            color: .red
        ),
        WebResult(
            title: "Guided Meditation for Sadness & Stress Relief",
            description: "A soothing 10-minute meditation to help release emotions",
            url: "calmspace.com",
            icon: "person.fill",
            color: .blue
        ),
        WebResult(
            title: "Crisis Text Line - Free Support",
            description: "Despite or grieve, you're not alone. Text us for free, 24/7. Your Moodiness He Yes Matters.",
            url: "crisistextline.org",
            icon: "phone.fill",
            color: .green
        ),
        WebResult(
            title: "Psychology Today",
            description: "What the Research Shows: Why do you? >>",
            url: "psychologytoday.com",
            icon: "doc.text.fill",
            color: .purple
        )
    ]
    
    var body: some View {
        ZStack {
            // Background
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Text("Web")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .opacity(0)
                }
                .padding()
                .background(Color.white)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $searchText)
                        .foregroundColor(.primary)
                    
                    Button(action: {
                        // Search action
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .foregroundColor(.purple)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                // Category Pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                    .foregroundColor(selectedCategory == category ? .white : .primary)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == category ? Color.purple : Color.gray.opacity(0.2))
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 10)
                
                // Web Results
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(webResults) { result in
                            WebResultCard(result: result)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Web Result Model
struct WebResult: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let url: String
    let icon: String
    let color: Color
}

// MARK: - Web Result Card
struct WebResultCard: View {
    let result: WebResult
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(result.color.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: result.icon)
                        .foregroundColor(result.color)
                        .font(.title3)
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(result.title)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    Text(result.url)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
            
            Text(result.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

#Preview {
    WebView()
}
