//
//  AccessibilitySettingsViewModel.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import SwiftUI

class AccessibilitySettingsViewModel: ObservableObject {
    @Published var highContrastEnabled: Bool = false
    @Published var largerTextEnabled: Bool = false
    @Published var voiceOverEnabled: Bool = false
    
    func toggleHighContrast() {
        highContrastEnabled.toggle()
        // Update UI styling or notify relevant parts of the app
    }
    
    func toggleLargerText() {
        largerTextEnabled.toggle()
        // Possibly post a notification or re-render with .dynamicTypeSize
    }
    
    func toggleVoiceOver() {
        voiceOverEnabled.toggle()
        // Potentially tie into system settings or adjust announcements
    }
}
