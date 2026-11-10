//
//  LoadingModifier.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 10/11/2026.
//

import SwiftUI

/// Overlays `LoadingView` on the content while `isLoading` is true.
struct LoadingModifier: ViewModifier {
    let isLoading: Bool

    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    LoadingView()
                        .transition(.opacity)
                }
            }
            .animation(.default, value: isLoading)
    }
}

extension View {
    /// Shows the loader when `isLoading` is true.
    func loading(_ isLoading: Bool) -> some View {
        modifier(LoadingModifier(isLoading: isLoading))
    }

    /// Shows the loader when `LoadingState.shared.isLoading` is true.
    func loading() -> some View {
        loading(LoadingState.shared.isLoading)
    }
}
