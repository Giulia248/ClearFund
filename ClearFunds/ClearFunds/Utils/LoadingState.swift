//
//  LoadingState.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 10/11/2026.
//

import Observation

/// Global loader state: set `LoadingState.shared.isLoading = true` from anywhere.
@Observable
final class LoadingState {
    static let shared = LoadingState()

    var isLoading = false

    private init() {}
}
