//
//  HomeViewModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/20/25.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var activityOptions: [String] = ["Running", "Walking", "Cycling"]
    @Published var selectedActivity: String?

    func selectActivity(_ activity: String) {
        selectedActivity = activity
    }
}
