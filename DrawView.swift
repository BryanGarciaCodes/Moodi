//
//  DrawView.swift
//  Moodi
//
//  Created by on 11/24/25.
//

import SwiftUI

struct DrawView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentDrawing = Drawing()
    @State private var drawings: [Drawing] = []
    @State private var selectedColor = Color.black
    @State private var lineWidth: CGFloat = 3.0
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.3),
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
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    Text("Draw")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    HStack(spacing: 15) {
                        Button(action: {
                            // Import image
                        }) {
                            Image(systemName: "photo")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                        
                        Button(action: {
                            // Take photo
                        }) {
                            Image(systemName: "camera")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.9))
                
                Text("Title...")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.8))
                
                // Canvas
                ZStack {
                    Color.white
                    
                    Canvas { context, size in
                        for drawing in drawings {
                            var path = Path()
                            path.addLines(drawing.points)
                            context.stroke(
                                path,
                                with: .color(drawing.color),
                                lineWidth: drawing.lineWidth
                            )
                        }
                        
                        var path = Path()
                        path.addLines(currentDrawing.points)
                        context.stroke(
                            path,
                            with: .color(currentDrawing.color),
                            lineWidth: currentDrawing.lineWidth
                        )
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                currentDrawing.points.append(value.location)
                            }
                            .onEnded { _ in
                                drawings.append(currentDrawing)
                                currentDrawing = Drawing(color: selectedColor, lineWidth: lineWidth)
                            }
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Toolbar
                VStack(spacing: 15) {
                    // Color Palette
                    HStack(spacing: 15) {
                        ForEach([Color.black, Color.red, Color.blue, Color.green, Color.yellow, Color.purple], id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: selectedColor == color ? 3 : 0)
                                )
                                .onTapGesture {
                                    selectedColor = color
                                    currentDrawing.color = color
                                }
                        }
                    }
                    
                    // Actions
                    HStack(spacing: 30) {
                        Button(action: {
                            // Undo
                            if !drawings.isEmpty {
                                drawings.removeLast()
                            }
                        }) {
                            Image(systemName: "arrow.uturn.backward.circle")
                                .font(.title2)
                                .foregroundColor(.purple)
                        }
                        
                        Button(action: {
                            // Shape tools
                        }) {
                            Image(systemName: "diamond")
                                .font(.title2)
                                .foregroundColor(.purple)
                        }
                        
                        Button(action: {
                            // Circle tools
                        }) {
                            Image(systemName: "circle")
                                .font(.title2)
                                .foregroundColor(.purple)
                        }
                        
                        Button(action: {
                            // Square tools
                        }) {
                            Image(systemName: "square")
                                .font(.title2)
                                .foregroundColor(.purple)
                        }
                    }
                    
                    // Save/New Buttons
                    HStack(spacing: 15) {
                        Button(action: {
                            // Save drawing
                        }) {
                            Text("Save")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [Color.purple, Color.pink],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(15)
                        }
                        
                        Button(action: {
                            // New drawing
                            drawings.removeAll()
                            currentDrawing = Drawing(color: selectedColor, lineWidth: lineWidth)
                        }) {
                            Text("New")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [Color.purple, Color.pink],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(15)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.white.opacity(0.95))
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Drawing Model
struct Drawing {
    var points: [CGPoint] = []
    var color: Color = .black
    var lineWidth: CGFloat = 3.0
}

#Preview {
    DrawView()
}
