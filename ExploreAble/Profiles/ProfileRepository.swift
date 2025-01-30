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
        print("[ProfileRepository] Attempting to create profile: \(profile)")

        do {
            let response = try await supabase
                .from("profiles")
                .insert(profile)
                .select() // Log the inserted data if available
                .execute()
            print("[ProfileRepository] Profile creation successful. Response: \(response)")
        } catch {
            print("[ProfileRepository] Failed to create profile. Error: \(error.localizedDescription)")
            throw error
        }
    }

    func fetchProfile(userId: String) async throws -> Profile? {
        print("[ProfileRepository] Fetching profile for user ID: \(userId)")

        do {
            let profile: Profile? = try await supabase
                .from("profiles")
                .select("*")
                .eq("id", value: userId)
                .single()
                .execute()
                .value

            if let profile = profile {
                print("[ProfileRepository] Profile fetched successfully: \(profile)")
            } else {
                print("[ProfileRepository] No profile found for user ID: \(userId)")
            }

            return profile
        } catch {
            print("[ProfileRepository] Failed to fetch profile. Error: \(error.localizedDescription)")
            throw error
        }
    }
}

