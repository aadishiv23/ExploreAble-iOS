//
//  AuthManager.swift
//  Radius
//
//  Created by Aadi Shiv Malhotra on 5/15/24.
//

import Foundation
import Supabase

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var needsProfileSetup = false
    
    static let shared = AuthManager()


    init() {
        setupAuthListener()
    }

    private func setupAuthListener() {
        Task {
            for await state in await supabase.auth.authStateChanges {
                DispatchQueue.main.async {
                    self.isAuthenticated = state.session != nil
                }

                if state.session != nil {
                    Task {
                        await self.checkProfileSetup()
                    }
                } else {
                    self.needsProfileSetup = false
                }
            }
        }
    }

    private func checkProfileSetup() async {
        do {
            let user = try await supabase.auth.session.user
            let userId = user.id
            
            // Fetch profile from Supabase
            let profiles: [Profile] = try await supabase
                .from("profiles")
                .select("*")
                .eq("id", value: userId)
                .execute()
                .value
            
            if let profile = profiles.first {
                // Profile exists, check if setup is incomplete
                DispatchQueue.main.async {
                    self.needsProfileSetup = profile.name.isEmpty || profile.gender.isEmpty || profile.name == "no_current_name" || profile.gender == "no_current_gender"
                }
            } else {
                // No profile found, user needs to create a profile
                DispatchQueue.main.async {
                    self.needsProfileSetup = true
                }
            }
        } catch {
            // Handle errors during the query
            print("Error checking profile setup: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.needsProfileSetup = true // Assume setup is needed on error
            }
        }
    }
}
