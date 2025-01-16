//
//  EditProfileView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation
import SwiftUI

struct EditProfileView: View {
    @ObservedObject var vm: ProfileViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var editedName: String = ""
    @State private var editedBio: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("Name", text: $editedName)
                    TextField("Bio", text: $editedBio)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        vm.updateProfile(name: editedName, bio: editedBio)
                        dismiss()
                    }
                }
            }
            .onAppear {
                editedName = vm.currentUser.name
                editedBio = vm.currentUser.bio
            }
        }
    }
}
