//
//  CommunityViewModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import SwiftUI

class CommunityViewModel: ObservableObject {
    @Published var upcomingEvents: [GroupEvent] = []
    
    init() {
        // Example: fetch from server
        self.upcomingEvents = [
            GroupEvent(title: "Adaptive Hiking Meetup", location: "Green Hill Park", date: Date(), participants: 12, accessibilityTags: ["Wheelchair Ramp", "Paved Trails"]),
            GroupEvent(title: "Kayaking for All", location: "River Bend", date: Date().addingTimeInterval(86400), participants: 8, accessibilityTags: ["Life Jackets", "Assistance Available"])
        ]
    }
    
    func createEvent(_ event: GroupEvent) {
        // Post to server or local DB, then append
        upcomingEvents.append(event)
    }
}

struct GroupEvent: Identifiable {
    let id = UUID()
    var title: String
    var location: String
    var date: Date
    var participants: Int
    var accessibilityTags: [String]
}
