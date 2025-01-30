//
//  ProfileCreationViewModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation
import SwiftUI

/// ViewModel for handling profile creation and UI state.
@MainActor
class ProfileViewModel: ObservableObject {
    @Published var profile = Profile()
    @Published var isLoading = false
    @Published var error: String?
    @Published var isProfileCreated = false

    private let service: ProfileService

    init(service: ProfileService = ProfileService()) {
        self.service = service
    }

    /// Creates a new profile.
    func createProfile() async {
        isLoading = true
        error = nil

        do {
            // Ensure the current user's ID is set in the profile
            if let currentUserId = supabase.auth.currentUser?.id {
                profile.id = currentUserId
            } else {
                throw NSError(
                    domain: "ProfileViewModel",
                    code: 401,
                    userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]
                )
            }

            print("[ProfileViewModel] Attempting to create profile with data: \(profile)")
            try await service.createProfile(profile)
            isProfileCreated = true
            print("[ProfileViewModel] Profile created successfully")
        } catch {
            self.error = error.localizedDescription
            print("[ProfileViewModel] Error creating profile: \(error.localizedDescription)")
        }

        isLoading = false
    }

}
