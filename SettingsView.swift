//
//  SettingsView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var notificationEnabled = true
    @State private var soundEnabled = true
    @State private var darkMode = false
    @State private var selectedVoice = "Female"
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.indigo.opacity(0.3),
                    Color.purple.opacity(0.3)
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
                    
                    Text("Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Invisible button for centering
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .opacity(0)
                }
                .padding()
                .background(Color.indigo.opacity(0.6))
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Moodi AI Settings Icon
                        VStack(spacing: 15) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [Color.indigo, Color.purple],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                )
                            
                            Text("Moodi AI Voice")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 30)
                        
                        // Voice Selection
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Voice")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                            
                            HStack(spacing: 15) {
                                VoiceButton(title: "Male", isSelected: selectedVoice == "Male") {
                                    selectedVoice = "Male"
                                }
                                VoiceButton(title: "Female", isSelected: selectedVoice == "Female") {
                                    selectedVoice = "Female"
                                }
                                VoiceButton(title: "Custom", isSelected: selectedVoice == "Custom") {
                                    selectedVoice = "Custom"
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                        // Theme Selection
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Themes")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                            
                            HStack(spacing: 15) {
                                Toggle("Dark/Light", isOn: $darkMode)
                                    .toggleStyle(SwitchToggleStyle(tint: .purple))
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(15)
                            }
                            .padding(.horizontal)
                            
                            // Theme Preview Grid (placeholder)
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                                ForEach(0..<6) { _ in
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(height: 80)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                        // Notifications
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Notifications")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                            
                            VStack(spacing: 10) {
                                SettingToggle(title: "Mute", icon: "bell.slash.fill", isOn: $notificationEnabled)
                                SettingToggle(title: "Sounds", icon: "speaker.wave.2.fill", isOn: $soundEnabled)
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                        Spacer(minLength: 30)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Voice Button Component
struct VoiceButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : .primary)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isSelected ? Color.purple : Color.gray.opacity(0.2))
                .cornerRadius(15)
        }
    }
}

// MARK: - Setting Toggle Component
struct SettingToggle: View {
    let title: String
    let icon: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.purple)
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .purple))
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(15)
    }
}

#Preview {
    SettingsView()
}
