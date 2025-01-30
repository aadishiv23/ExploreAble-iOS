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
        print("[ProfileService] Attempting to create profile with data: \(profile)")

        do {
            try await repository.createProfile(profile)
            print("[ProfileService] Profile created successfully")
        } catch {
            print("[ProfileService] Error creating profile: \(error.localizedDescription)")
            throw error
        }
    }

    /// Fetches the user profile by ID.
    func fetchProfile(userId: String) async throws -> Profile? {
        print("[ProfileService] Attempting to fetch profile for user ID: \(userId)")

        do {
            let profile = try await repository.fetchProfile(userId: userId)
            if let profile = profile {
                print("[ProfileService] Profile fetched successfully: \(profile)")
            } else {
                print("[ProfileService] Profile does not exist for user ID: \(userId)")
            }
            return profile
        } catch {
            print("[ProfileService] Error fetching profile: \(error.localizedDescription)")
            throw error
        }
    }
}

