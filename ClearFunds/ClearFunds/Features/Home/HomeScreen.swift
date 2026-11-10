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
        let user = storage.username ?? ""
        NavigationStack {
            ContentUnavailableView {
                Label("\(AppStrings.homeGreetings.text)\(user)", systemImage: "eurosign.circle")
            } description: {
                Text(AppStrings.homeSummaryPlaceholder.text)
            }
            .navigationTitle(AppStrings.homeTitle.text)
            .toolbar {
                Button(AppStrings.homeLogOut.text, systemImage: "rectangle.portrait.and.arrow.right", action: storage.logout)
            }
        }
    }
}

#Preview {
    HomeScreen(storage: .shared)
}
