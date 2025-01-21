//
//  ExploreAbleApp.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import SwiftUI

@main
struct ExploreAbleApp: App {
    /// AuthManager shared instance for authentication state.
    @StateObject private var authManager = AuthManager.shared

    /// Tracks whether the user has a profile.
    @State private var hasProfile = false

    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isAuthenticated {
                    if hasProfile {
                        TabItemsView()
                    } else {
                        ProfileCreationView(hasProfile: $hasProfile) // Pass binding
                            .interactiveDismissDisabled()
                            .onAppear {
                                checkProfile()
                            }
                    }
                } else {
                    SignInView()
                }
            }
        }
    }

    /// Checks if the authenticated user has a profile.
    private func checkProfile() {
        Task {
            do {
                let user = try await supabase.auth.session.user
                let userId = user.id
                let profile = try await ProfileService().fetchProfile(userId: userId.uuidString)
                await MainActor.run {
                    hasProfile = profile != nil
                }
            } catch {
                print("Error checking profile: \(error)")
            }
        }
    }
}
