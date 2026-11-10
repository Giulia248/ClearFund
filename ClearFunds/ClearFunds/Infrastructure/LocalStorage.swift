//
//  LocalStorage.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 09/11/2026.
//

import CommonCrypto
import Foundation
import Observation
import Security

/// Local persistence singleton backed by `UserDefaults`.
/// The password is never stored in plain text: only a random salt and a PBKDF2 hash are saved.
@Observable
final class LocalStorage {
    static let shared = LocalStorage()
    
    enum Key: String {
        case credentials = "storage.credentials"
        case isLoggedIn = "storage.isLoggedIn"
    }
    
    enum LoginError: LocalizedError {
        case emptyFields
        case wrongCredentials
        case hashingFailed
        
        var errorDescription: String? {
            switch self {
            case .emptyFields: String(localized: "Enter your name and password.")
            case .wrongCredentials: String(localized: "Incorrect name or password.")
            case .hashingFailed: String(localized: "Unable to save the credentials.")
            }
        }
    }
    
    private struct Credentials: Codable {
        let username: String
        let salt: Data
        let hash: Data
    }
    
    private static let pbkdf2Rounds: UInt32 = 100_000
    
    private(set) var username: String?
    private(set) var isLoggedIn: Bool
    
    @ObservationIgnored private let defaults: UserDefaults
    
    private init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.isLoggedIn = defaults.bool(forKey: Key.isLoggedIn.rawValue)
        self.username = nil
        self.username = storedCredentials()?.username
    }
    
    // MARK: - Login
    
    /// Call from the login form.
    /// Creates the local account if none exists yet, otherwise verifies the credentials.
    func start(name: String, password: String) throws {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty, !password.isEmpty else { throw LoginError.emptyFields }
        
        if let stored = storedCredentials() {
            guard stored.username == name,
                  let hash = Self.hash(password, salt: stored.salt),
                  Self.constantTimeEqual(hash, stored.hash) else {
                throw LoginError.wrongCredentials
            }
        } else {
            guard let salt = Self.randomSalt(),
                  let hash = Self.hash(password, salt: salt) else {
                throw LoginError.hashingFailed
            }
            try save(Credentials(username: name, salt: salt, hash: hash), forKey: Key.credentials.rawValue)
            username = name
        }
        
        defaults.set(true, forKey: Key.isLoggedIn.rawValue)
        isLoggedIn = true
    }
    
    /// Ends the session but keeps the saved account.
    func logout() {
        defaults.set(false, forKey: Key.isLoggedIn.rawValue)
        isLoggedIn = false
    }
    
    /// Deletes the account and all app data.
    func reset() {
        if let domain = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: domain)
        }
        username = nil
        isLoggedIn = false
    }
    
    // MARK: - Generic data
    
    func save<T: Encodable>(_ value: T, forKey key: String) throws {
        defaults.set(try JSONEncoder().encode(value), forKey: key)
    }
    
    func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }
    
    func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    // MARK: - Hash
    
    private func storedCredentials() -> Credentials? {
        load(Credentials.self, forKey: Key.credentials.rawValue)
    }
    
    private static func randomSalt(length: Int = 16) -> Data? {
        var bytes = [UInt8](repeating: 0, count: length)
        guard SecRandomCopyBytes(kSecRandomDefault, length, &bytes) == errSecSuccess else { return nil }
        return Data(bytes)
    }
    
    private static func hash(_ password: String, salt: Data) -> Data? {
        var derived = [UInt8](repeating: 0, count: 32)
        let status = salt.withUnsafeBytes { saltBytes in
            CCKeyDerivationPBKDF(
                CCPBKDFAlgorithm(kCCPBKDF2),
                password, password.utf8.count,
                saltBytes.bindMemory(to: UInt8.self).baseAddress, salt.count,
                CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA256),
                pbkdf2Rounds,
                &derived, derived.count
            )
        }
        return status == kCCSuccess ? Data(derived) : nil
    }
    
    private static func constantTimeEqual(_ a: Data, _ b: Data) -> Bool {
        guard a.count == b.count else { return false }
        return zip(a, b).reduce(0) { $0 | ($1.0 ^ $1.1) } == 0
    }
}
