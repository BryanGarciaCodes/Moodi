//
//  LockScreenView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct LockScreenView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentTime = Date()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.7),
                    Color.cyan.opacity(0.5)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Status Bar Icons
                HStack {
                    Image(systemName: "wifi")
                        .foregroundColor(.white)
                    Image(systemName: "cellularbars")
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text("100%")
                        .font(.caption)
                        .foregroundColor(.white)
                    Image(systemName: "battery.100")
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                Spacer()
                
                // Time Display
                VStack(spacing: 5) {
                    Text("Monday, June 6")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(timeString(from: currentTime))
                        .font(.system(size: 72, weight: .thin))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Notification Card
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.pink, Color.purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 30, height: 30)
                            
                            Text("M")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Moodi")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("New Notification")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        
                        Spacer()
                        
                        Text("9:41 AM")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.2))
                        .blur(radius: 10)
                )
                .padding(.horizontal)
                
                Spacer()
                
                // Bottom Icons
                HStack(spacing: 60) {
                    Button(action: {}) {
                        Image(systemName: "flashlight.off.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "camera.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 20)
                
                // Swipe Up Indicator
                VStack(spacing: 5) {
                    Image(systemName: "chevron.up")
                        .foregroundColor(.white.opacity(0.6))
                    Text("Swipe up to open")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.bottom, 30)
            }
        }
        .navigationBarHidden(true)
        .onReceive(timer) { _ in
            currentTime = Date()
        }
        .onTapGesture {
            dismiss()
        }
    }
    
    func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    LockScreenView()
}
