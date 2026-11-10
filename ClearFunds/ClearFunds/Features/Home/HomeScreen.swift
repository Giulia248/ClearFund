//
//  HomeScreen.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 10/11/2026.
//

import SwiftUI

struct HomeScreen: View {
    let storage: LocalStorage

    var body: some View {
        NavigationStack {
            ContentUnavailableView(
                "Hello, \(storage.username ?? "")",
                systemImage: "eurosign.circle",
                description: Text("The summary of your income and expenses will appear here.")
            )
            .navigationTitle("Home")
            .toolbar {
                Button("Log out", systemImage: "rectangle.portrait.and.arrow.right", action: storage.logout)
            }
        }
    }
}

#Preview {
    HomeScreen(storage: .shared)
}
