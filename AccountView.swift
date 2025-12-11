//
//  AccountView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.dismiss) var dismiss
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var username = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    
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
                    
                    Text("Account")
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
                    VStack(spacing: 25) {
                        // Profile Picture
                        VStack(spacing: 15) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: "person.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                
                                // Edit button
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Image(systemName: "pencil")
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    )
                                    .offset(x: 35, y: 35)
                            }
                        }
                        .padding(.top, 30)
                        
                        // Form Fields
                        VStack(spacing: 15) {
                            AccountTextField(icon: "person", placeholder: "First Name", text: $firstName)
                            AccountTextField(icon: "person", placeholder: "Last Name", text: $lastName)
                            AccountTextField(icon: "at", placeholder: "Username", text: $username)
                            AccountTextField(icon: "envelope", placeholder: "Email", text: $email)
                            AccountTextField(icon: "phone", placeholder: "Phone Number", text: $phoneNumber)
                            AccountTextField(icon: "lock", placeholder: "Password", text: $password, isSecure: true)
                        }
                        .padding(.horizontal)
                        
                        // Action Buttons
                        VStack(spacing: 15) {
                            Button(action: {
                                // Reset action
                            }) {
                                Text("Reset")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gray.opacity(0.6))
                                    .cornerRadius(15)
                            }
                            
                            Button(action: {
                                // Update action
                            }) {
                                Text("Update")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        LinearGradient(
                                            colors: [Color.purple, Color.indigo],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Account Text Field Component
struct AccountTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.purple)
                .frame(width: 20)
            
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
    }
}

#Preview {
    AccountView()
}
