//
//  ProfileViewModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User
    
    init() {
        // Placeholder user
        currentUser = User(
            name: "John Doe",
            bio: "Fitness Enthusiast",
            accessibilityTags: ["Wheelchair-friendly", "Sign Language"],
            totalActivities: 28,
            totalHours: 142,
            points: 8500
        )
    }
    
    // Example function for editing profile
    func updateProfile(name: String, bio: String) {
        currentUser.name = name
        currentUser.bio = bio
        // Save to database or server...
    }
}
