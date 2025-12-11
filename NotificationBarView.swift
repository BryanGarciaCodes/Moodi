//
//  NotificationBarView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct NotificationBarView: View {
    @Environment(\.dismiss) var dismiss
    
    let notifications = [
        NotificationItem(app: "Moodi", title: "New Notification", time: "now"),
        NotificationItem(app: "FaceTime", title: "Missed Call", time: "2m ago"),
        NotificationItem(app: "Calendar", title: "Event Starting Soon", time: "5m ago"),
        NotificationItem(app: "Photos", title: "Memory Created", time: "10m ago"),
        NotificationItem(app: "Camera", title: "Photo Saved", time: "15m ago")
    ]
    
    var body: some View {
        ZStack {
            // Blurred Background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .blur(radius: 20)
            
            VStack(spacing: 0) {
                // Home Indicator
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.white.opacity(0.6))
                    .frame(width: 40, height: 5)
                    .padding(.top, 10)
                
                Spacer()
                
                // Notification Cards
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(notifications) { notification in
                            NotificationCard(notification: notification)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarHidden(true)
        .onTapGesture {
            dismiss()
        }
    }
}

// MARK: - Notification Model
struct NotificationItem: Identifiable {
    let id = UUID()
    let app: String
    let title: String
    let time: String
}

// MARK: - Notification Card
struct NotificationCard: View {
    let notification: NotificationItem
    
    var appIcon: String {
        switch notification.app {
        case "Moodi": return "brain.head.profile"
        case "FaceTime": return "video.fill"
        case "Calendar": return "calendar"
        case "Photos": return "photo.fill"
        case "Camera": return "camera.fill"
        default: return "app.fill"
        }
    }
    
    var appColor: Color {
        switch notification.app {
        case "Moodi": return .purple
        case "FaceTime": return .green
        case "Calendar": return .red
        case "Photos": return .blue
        case "Camera": return .gray
        default: return .blue
        }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            // App Icon
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(appColor)
                    .frame(width: 40, height: 40)
                
                Image(systemName: appIcon)
                    .foregroundColor(.white)
            }
            
            // Content
            VStack(alignment: .leading, spacing: 3) {
                Text(notification.app)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(notification.title)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
            }
            
            Spacer()
            
            // Time
            Text(notification.time)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.15))
                .blur(radius: 20)
        )
    }
}

#Preview {
    NotificationBarView()
}
