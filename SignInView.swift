//
//  SignInView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.dismiss) var dismiss
    @State private var emailOrPhone = ""
    @State private var password = ""
    @State private var rememberMe = false
    
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
            
            VStack(spacing: 30) {
                Spacer()
                
                // Moodi Logo
                VStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .fill(Color.black.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .offset(x: -10, y: 10)
                        
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.pink, Color.purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 100, height: 100)
                    }
                }
                
                Text("Welcome Back!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                // Input Fields
                VStack(spacing: 15) {
                    // Email/Phone Field
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(.white.opacity(0.7))
                        TextField("Username/ Email / Phone Number", text: $emailOrPhone)
                            .foregroundColor(.white)
                            .placeholder(when: emailOrPhone.isEmpty) {
                                Text("Username/ Email / Phone Number")
                                    .foregroundColor(.white.opacity(0.5))
                            }
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(15)
                    
                    // Password Field
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.white.opacity(0.7))
                        SecureField("Password", text: $password)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(15)
                    
                    // Forgot Password
                    HStack {
                        Spacer()
                        Button(action: {
                            // Forgot password action
                        }) {
                            Text("Forget?")
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                }
                .padding(.horizontal, 40)
                
                // Navigation Arrows
                HStack(spacing: 40) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left.circle")
                            .font(.system(size: 50))
                            .foregroundColor(.white.opacity(0.3))
                    }
                    
                    Button(action: {
                        // Sign in action
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Sign Up Link
                HStack(spacing: 5) {
                    Text("Already have an account?")
                        .foregroundColor(.white.opacity(0.8))
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .font(.subheadline)
                .padding(.bottom, 50)
            }
        }
        .navigationBarHidden(true)
    }
}

// Helper extension for placeholder
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

#Preview {
    SignInView()
}
