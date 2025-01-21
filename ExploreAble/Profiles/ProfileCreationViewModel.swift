//
//  ProfileCreationViewModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation
import SwiftUI

/// ViewModel for handling profile creation and UI state.
@MainActor
class ProfileViewModel: ObservableObject {
    @Published var profile = Profile()
    @Published var isLoading = false
    @Published var error: String?
    @Published var isProfileCreated = false

    private let service: ProfileService

    init(service: ProfileService = ProfileService()) {
        self.service = service
    }

    /// Creates a new profile.
    func createProfile() async {
        isLoading = true
        error = nil

        do {
            try await service.createProfile(profile)
            isProfileCreated = true
        } catch {
            self.error = error.localizedDescription
        }

        isLoading = false
    }
}
