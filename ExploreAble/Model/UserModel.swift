//
//  UserModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation

struct User: Identifiable {
    let id: UUID = UUID()
    var name: String
    var bio: String
    var accessibilityTags: [String]
    // Could include location, profile picture URL, etc.
    
    // Example stat/achievement fields
    var totalActivities: Int
    var totalHours: Double
    var points: Double
}
