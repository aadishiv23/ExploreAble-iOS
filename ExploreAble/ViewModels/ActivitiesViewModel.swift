//
//  ActivitiesViewModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation
import SwiftUI

class ActivitiesViewModel: ObservableObject {
    @Published var selectedFilter = "All"
    let filters = ["All", "Running", "Cycling", "Yoga", "Gym"]
    
    // Dummy data for example; you would fetch real data
    @Published var activities: [ActivityData] = [
        ActivityData(title: "Morning Run", duration: "30 min", participants: "5", color: .blue),
        ActivityData(title: "Group Yoga", duration: "45 min", participants: "8", color: .purple),
        ActivityData(title: "Gym Workout", duration: "60 min", participants: "2", color: .pink),
        // ...
    ]
    
    // Filter logic
    var filteredActivities: [ActivityData] {
        if selectedFilter == "All" {
            return activities
        }
        return activities.filter { $0.title.contains(selectedFilter) }
    }
    
    func filterBy(_ filter: String) {
        selectedFilter = filter
    }
}

struct ActivityData: Identifiable {
    let id = UUID()
    var title: String
    var duration: String
    var participants: String
    var color: Color
}
