//
//  ProfileService.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation

/// Handles business logic for user profiles.
class ProfileService {
    private let repository: ProfileRepository

    init(repository: ProfileRepository = SupabaseProfileRepository()) {
        self.repository = repository
    }

    /// Creates a new user profile.
    func createProfile(_ profile: Profile) async throws {
        try await repository.createProfile(profile)
    }

    /// Fetches the user profile by ID.
    func fetchProfile(userId: String) async throws -> Profile? {
        return try await repository.fetchProfile(userId: userId)
    }
}
