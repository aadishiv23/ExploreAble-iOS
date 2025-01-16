//
//  HomeViewModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import SwiftUI

struct Post: Identifiable, Equatable {
    let id = UUID()
    let author: String
    let profileImage: String // system image name
    let content: String
    let mediaType: MediaType?
    let mediaUrl: String?
    let timestamp: Date
    var likes: Int
    var comments: [Comment]
    var isLiked: Bool

    /// Add Equatable conformance
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
}

struct Comment: Identifiable {
    let id = UUID()
    let author: String
    let profileImage: String
    let content: String
    let timestamp: Date
}

enum MediaType {
    case image
    case video
}

class HomeViewModel: ObservableObject {
    @Published var completedActivities: Int = 5
    @Published var totalActivities: Int = 10
    @Published var showActivitySheet: Bool = false
    @Published var selectedActivity: String?
    @Published var showWeeklyDetail: Bool = false
    @Published var selectedPost: Post?
    @Published var activityOptions: [String] = ["Running", "Walking", "Cycling"]

    @Published var posts: [Post] = [
        Post(
            author: "Sarah Chen",
            profileImage: "person.circle.fill",
            content: "Just completed a 5K run! Personal best time 🏃‍♀️💪 #fitness #running",
            mediaType: .image,
            mediaUrl: "run_completion",
            timestamp: Date().addingTimeInterval(-3600),
            likes: 24,
            comments: [
                Comment(
                    author: "Mike",
                    profileImage: "person.circle.fill",
                    content: "Amazing work! 🎉",
                    timestamp: Date().addingTimeInterval(-1800)
                ),
                Comment(
                    author: "Lisa",
                    profileImage: "person.circle.fill",
                    content: "What's your training routine?",
                    timestamp: Date().addingTimeInterval(-900)
                )
            ],
            isLiked: false
        ),
        Post(
            author: "Alex Turner",
            profileImage: "person.circle.fill",
            content: "Morning yoga session with the sunrise 🧘‍♂️ Starting the day right!",
            mediaType: nil,
            mediaUrl: nil,
            timestamp: Date().addingTimeInterval(-7200),
            likes: 15,
            comments: [],
            isLiked: true
        )
    ]

    var nextScheduledActivity: (name: String, time: Date) = ("Evening Run", Date().addingTimeInterval(3600 * 3))

    var analyticsData: [(label: String, value: String)] = [
        ("Total Distance", "42.5 km"),
        ("Active Minutes", "380"),
        ("Calories Burned", "2,450")
    ]

    var progressPercentage: Int {
        guard totalActivities > 0 else {
            return 0
        }
        return Int((Double(completedActivities) / Double(totalActivities)) * 100)
    }

    func selectActivity(_ activity: String) {
        selectedActivity = activity
        showActivitySheet = true
    }

    func toggleLike(for post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            var updatedPost = posts[index]
            updatedPost.isLiked.toggle()
            updatedPost.likes += updatedPost.isLiked ? 1 : -1

            // Replace the post in the array
            posts[index] = updatedPost
        }
    }

}
