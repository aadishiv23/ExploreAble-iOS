//
//  AccessibilitySettingsView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation
import SwiftUI

struct AccessibilitySettingsView: View {
    @StateObject private var vm = AccessibilitySettingsViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Visual")) {
                Toggle("High Contrast Mode", isOn: $vm.highContrastEnabled)
                    .onChange(of: vm.highContrastEnabled) { _ in
                        vm.toggleHighContrast()
                    }
                Toggle("Larger Text", isOn: $vm.largerTextEnabled)
                    .onChange(of: vm.largerTextEnabled) { _ in
                        vm.toggleLargerText()
                    }
            }
            
            Section(header: Text("Audio")) {
                Toggle("VoiceOver", isOn: $vm.voiceOverEnabled)
                    .onChange(of: vm.voiceOverEnabled) { _ in
                        vm.toggleVoiceOver()
                    }
            }
        }
        .navigationTitle("Accessibility")
    }
}
