//
//  Strings.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 10/11/2026.
//

import Foundation

enum AppStrings: String {
    case appName = "ClearFund"

    // Login
    case loginName = "Name"
    case loginPassword = "Password"
    case loginLogIn = "Log in"
    case loginEmptyFields = "Enter your name and password."
    case loginWrongCredentials = "Incorrect name or password."
    case loginSaveFailed = "Unable to save the credentials."

    // Home
    case homeTitle = "Home"
    case homeLogOut = "Log out"
    case homeSummaryPlaceholder = "The summary of your income and expenses will appear here."
    case homeGreetings = "Hello, "

    // Loading
    case loadingAccessibilityLabel = "Loading"

    /// Localized text, usable directly in `Text`, `Button`, `String(localized:)`, etc.
    var text: LocalizedStringResource {
        LocalizedStringResource(String.LocalizationValue(rawValue))
    }
}
