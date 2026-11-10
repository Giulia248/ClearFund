//
//  LoginViewModel.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 10/11/2026.
//

import Foundation
import Observation

@Observable
final class LoginViewModel {
    var name = ""
    var password = ""
    private(set) var errorMessage: String?

    @ObservationIgnored private let storage: LocalStorage

    init(storage: LocalStorage = .shared) {
        self.storage = storage
    }

    /// Creates the account on first use, otherwise verifies the credentials.
    /// On success `storage.isLoggedIn` becomes `true` and the root view switches screen.
    func submit() {
        do {
            try storage.start(name: name, password: password)
            errorMessage = nil
            password = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
