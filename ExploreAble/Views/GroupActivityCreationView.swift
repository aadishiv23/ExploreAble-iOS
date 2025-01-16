//
//  GroupActivityCreationView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation
import SwiftUI

struct GroupActivityCreationView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var title = ""
    @State private var location = ""
    @State private var date = Date()
    @State private var accessibilityTags: String = ""
    @State private var participantsCount: Int = 0
    
    var body: some View {
        Form {
            Section(header: Text("Event Details")) {
                TextField("Event Title", text: $title)
                TextField("Location", text: $location)
                DatePicker("Date", selection: $date, displayedComponents: .date)
            }
            
            Section(header: Text("Accessibility & Participants")) {
                TextField("Accessibility Tags (comma separated)", text: $accessibilityTags)
                Stepper(value: $participantsCount, in: 0...100) {
                    Text("Number of Participants: \(participantsCount)")
                }
            }
            
            Section {
                Button("Create") {
                    // Post event to your CommunityViewModel or server
                    let tagsArray = accessibilityTags
                        .components(separatedBy: ",")
                        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    
                    let newEvent = GroupEvent(
                        title: title,
                        location: location,
                        date: date,
                        participants: participantsCount,
                        accessibilityTags: tagsArray
                    )
                    // You might pass a binding or use an environment object to store
                    // For now, simply dismiss after creation
                    // communityVM.createEvent(newEvent)
                    
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("Create Group Activity")
        .navigationBarTitleDisplayMode(.inline)
    }
}
