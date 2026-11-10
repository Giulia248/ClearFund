//
//  MainAppScreen.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 09/11/2026.
//

import SwiftUI

/// App root: shows Home or Login depending on `LocalStorage.isLoggedIn`.
struct MainAppScreen: View {
    @State private var storage = LocalStorage.shared

    var body: some View {
        Group {
            if storage.isLoggedIn {
                HomeScreen(storage: storage)
            } else {
                LoginScreen()
            }
        }
        .animation(.default, value: storage.isLoggedIn)
        .loading()
    }
}

#Preview {
    MainAppScreen()
}
