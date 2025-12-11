//
//  SearchView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var selectedCategory = "All"
    
    let categories = ["All", "Tips", "Activities", "Music", "Articles"]
    
    let searchResults = [
        SearchResult(title: "Tips for calming anxiety", category: "Tips", icon: "lightbulb.fill", color: .orange),
        SearchResult(title: "Birthday gift ideas", category: "Activities", icon: "gift.fill", color: .pink),
        SearchResult(title: "Why do I feel empty now?", category: "Articles", icon: "doc.text.fill", color: .blue),
        SearchResult(title: "Relaxing locations near me", category: "Activities", icon: "map.fill", color: .green),
        SearchResult(title: "Mindful Steps: Managing Difficult Emotions", category: "Articles", icon: "book.fill", color: .purple)
    ]
    
    var filteredResults: [SearchResult] {
        if searchText.isEmpty && selectedCategory == "All" {
            return searchResults
        }
        
        return searchResults.filter { result in
            let matchesSearch = searchText.isEmpty || result.title.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategory == "All" || result.category == selectedCategory
            return matchesSearch && matchesCategory
        }
    }
    
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
                    
                    Text("Search")
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
                .background(Color.white)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchText)
                    
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.purple)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding()
                
                // Category Pills
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            CategoryPill(
                                title: category,
                                isSelected: selectedCategory == category
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 10)
                
                // Search Results
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(filteredResults) { result in
                            SearchResultCard(result: result)
                        }
                        
                        if filteredResults.isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 60))
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("No results found")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 100)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Search Result Model
struct SearchResult: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let icon: String
    let color: Color
}

// MARK: - Category Pill Component
struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color.purple : Color.gray.opacity(0.2))
                .cornerRadius(20)
        }
    }
}

// MARK: - Search Result Card Component
struct SearchResultCard: View {
    let result: SearchResult
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(result.color.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: result.icon)
                    .foregroundColor(result.color)
                    .font(.title3)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(result.title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(result.category)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

#Preview {
    SearchView()
}
