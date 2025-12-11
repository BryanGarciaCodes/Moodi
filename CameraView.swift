//
//  CameraView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @State private var flashMode = "off"
    @State private var isFrontCamera = false
    @State private var showPhotoLibrary = false
    
    var body: some View {
        ZStack {
            // Camera Preview (Black background as placeholder)
            Color.black
                .ignoresSafeArea()
            
            // Simulated camera preview with gradient
            LinearGradient(
                colors: [
                    Color.gray.opacity(0.8),
                    Color.gray.opacity(0.5)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack {
                // Top Controls
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // Flash Control
                    Button(action: {
                        cycleFlashMode()
                    }) {
                        Image(systemName: flashMode == "on" ? "bolt.fill" : flashMode == "auto" ? "bolt.badge.a.fill" : "bolt.slash.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                Spacer()
                
                // Photo Mode Label
                Text("Photo Mode")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.5))
                    )
                
                Spacer()
                
                // Bottom Controls
                HStack(spacing: 60) {
                    // Photo Library Button
                    Button(action: {
                        showPhotoLibrary = true
                    }) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 50, height: 50)
                            .overlay(
                                Image(systemName: "photo.on.rectangle")
                                    .foregroundColor(.white)
                            )
                    }
                    
                    // Capture Button
                    Button(action: {
                        // Capture photo
                        capturePhoto()
                    }) {
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 4)
                                .frame(width: 80, height: 80)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 70, height: 70)
                        }
                    }
                    
                    // Flip Camera Button
                    Button(action: {
                        isFrontCamera.toggle()
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showPhotoLibrary) {
            GalleryView()
        }
    }
    
    func capturePhoto() {
        // Simulate photo capture
        print("Photo captured!")
    }
    
    func cycleFlashMode() {
        if flashMode == "off" {
            flashMode = "on"
        } else if flashMode == "on" {
            flashMode = "auto"
        } else {
            flashMode = "off"
        }
    }
}

#Preview {
    CameraView()
}
