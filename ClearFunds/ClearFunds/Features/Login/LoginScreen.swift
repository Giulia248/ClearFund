//
//  LoginScreen.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 09/11/2026.
//

import SwiftUI

struct LoginScreen: View {
    @State private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?

    private enum Field {
        case name, password
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $viewModel.name)
                        .textContentType(.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focusedField, equals: .name)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .password }

                    SecureField("Password", text: $viewModel.password)
                        .textContentType(.password)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.go)
                        .onSubmit(viewModel.submit)
                } footer: {
                    if let message = viewModel.errorMessage {
                        Text(message)
                            .foregroundStyle(.red)
                    }
                }

                Section {
                    Button("Log in", action: viewModel.submit)
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("ClearFund")
        }
    }
}

#Preview {
    LoginScreen()
}
