//
//  ChatView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.dismiss) var dismiss
    @State private var messageText = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hello! How are we feeling today?", isUser: false),
        ChatMessage(text: "Sad", isUser: true)
    ]
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.4),
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
                    
                    // Moodi AI Logo
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.pink, Color.purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 40, height: 40)
                    }
                    
                    Spacer()
                    
                    // Invisible button for centering
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .opacity(0)
                }
                .padding()
                
                // Chat Messages
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(messages) { message in
                            ChatBubble(message: message)
                        }
                    }
                    .padding()
                }
                
                // Input Area
                HStack(spacing: 12) {
                    TextField("Type here...", text: $messageText)
                        .padding(12)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(25)
                    
                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 35))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.1))
            }
        }
        .navigationBarHidden(true)
    }
    
    func sendMessage() {
        guard !messageText.isEmpty else { return }
        
        // Add user message
        messages.append(ChatMessage(text: messageText, isUser: true))
        messageText = ""
        
        // Simulate AI response (in real app, this would call an API)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            messages.append(ChatMessage(text: "I understand you're feeling that way. Would you like to talk about what's making you feel sad?", isUser: false))
        }
    }
}

// MARK: - Chat Message Model
struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

// MARK: - Chat Bubble Component
struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            Text(message.text)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(message.isUser ? Color.blue.opacity(0.8) : Color.white.opacity(0.9))
                .foregroundColor(message.isUser ? .white : .primary)
                .cornerRadius(20)
                .frame(maxWidth: 280, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser { Spacer() }
        }
    }
}

#Preview {
    ChatView()
}
