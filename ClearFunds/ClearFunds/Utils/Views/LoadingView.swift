//
//  LoadingView.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 10/11/2026.
//

import SwiftUI

/// Three animated dots on a translucent background. Use it through `.loading(_:)`.
struct LoadingView: View {
    @State private var scale = false
    var body: some View {
        ZStack {
            Color.white.opacity(0.8)
                .ignoresSafeArea()
            HStack(spacing: 8) {
                ForEach(0..<3) { i in
                    Circle()
                        .frame(width: 10, height: 10)
                        .scaleEffect(scale ? 1 : 0.5)
                        .animation(.easeInOut(duration: 0.6).repeatForever().delay(Double(i) * 0.2), value: scale)
                }
            }
            .onAppear { scale.toggle() }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Loading")
    }
}

#Preview {
    LoadingView()
}
