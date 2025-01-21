//
//  ProfileRepository.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation
import Supabase

struct ProfileDTO: Codable {
    let id: String // Supabase requires String
    var name: String
    var age: Int
    var gender: String
}

/// Protocol for handling data access related to user profiles.
protocol ProfileRepository {
    func createProfile(_ profile: Profile) async throws
    func fetchProfile(userId: String) async throws -> Profile?
}

/// Implementation of `ProfileRepository` using Supabase.
class SupabaseProfileRepository: ProfileRepository {
    func createProfile(_ profile: Profile) async throws {
        try await supabase
            .from("profiles")
            .insert(profile)
            .execute()
    }

    func fetchProfile(userId: String) async throws -> Profile? {
        let profile: Profile? = try await supabase
            .from("profiles")
            .select("*")
            .eq("id", value: userId)
            .single()
            .execute()
            .value

        
        return profile
    }
}
