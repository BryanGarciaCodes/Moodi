//
//  LocationView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI
import MapKit

struct LocationView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var showingLocationCard = true
    
    var body: some View {
        ZStack {
            // Map
            Map(coordinateRegion: $region, annotationItems: [LocationAnnotation.coffeeShop]) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
            }
            .ignoresSafeArea()
            
            VStack {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Text("Location")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .opacity(0)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.95))
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Input text", text: $searchText)
                    
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding(.horizontal)
                
                Spacer()
                
                // Location Card (Bottom Sheet)
                if showingLocationCard {
                    VStack(spacing: 15) {
                        // Drag Handle
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 5)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.caption)
                                    Text("4.5")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                Text("Coffee Shop")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                
                                Text("Come and enjoy a nice relaxing cup of coffee as you can enjoy here at our shop!")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        // GO Button
                        Button(action: {
                            // Navigate to location
                        }) {
                            Text("GO")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 80, height: 80)
                                .background(
                                    Circle()
                                        .fill(Color.green)
                                )
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.top, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.1), radius: 10)
                    )
                    .transition(.move(edge: .bottom))
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Location Annotation
struct LocationAnnotation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    
    static let coffeeShop = LocationAnnotation(
        name: "Coffee Shop",
        coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    )
}

#Preview {
    LocationView()
}
