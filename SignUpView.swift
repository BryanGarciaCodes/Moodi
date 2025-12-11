//
//  SignUpView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct SignUpView: View {
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
                    Color.blue.opacity(0.6),
                    Color.purple.opacity(0.7),
                    Color.pink.opacity(0.6)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Header with Logo
                VStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 80, height: 80)
                            .offset(x: -8, y: 8)
                        
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.pink, Color.purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 80, height: 80)
                    }
                    .padding(.top, 40)
                    
                    Text("Create Your Moodi Account")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                // Form Fields
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        SignUpTextField(icon: "person.fill", placeholder: "First Name", text: $firstName)
                        SignUpTextField(icon: "person.fill", placeholder: "Last Name", text: $lastName)
                        SignUpTextField(icon: "at", placeholder: "Username", text: $username)
                        SignUpTextField(icon: "envelope.fill", placeholder: "Email", text: $email)
                        SignUpTextField(icon: "phone.fill", placeholder: "Phone Number", text: $phoneNumber)
                        SignUpTextField(icon: "lock.fill", placeholder: "Password", text: $password, isSecure: true)
                    }
                    .padding(.horizontal, 30)
                }
                
                // Navigation Arrows
                HStack(spacing: 40) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.white.opacity(0.3))
                    }
                    
                    Button(action: {
                        // Sign up action
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                }
                .padding(.vertical, 20)
                
                // Sign In Link
                HStack(spacing: 5) {
                    Text("Already have an account?")
                        .foregroundColor(.white.opacity(0.8))
                    Button(action: { dismiss() }) {
                        Text("Sign In")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .font(.subheadline)
                .padding(.bottom, 30)
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Sign Up Text Field Component
struct SignUpTextField: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white.opacity(0.7))
                .frame(width: 20)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(.white)
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
    }
}

#Preview {
    SignUpView()
}
