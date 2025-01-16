//
//  ProfileView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
    @State private var isEditingProfile = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Profile Header
                    VStack(spacing: 15) {
                        // In production, replace with AsyncImage or real image logic
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Circle().fill(Color.blue.opacity(0.1)))
                        
                        VStack(spacing: 5) {
                            Text(vm.currentUser.name)
                                .font(.title.bold())
                            Text(vm.currentUser.bio)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // Stats Row
                        HStack(spacing: 30) {
                            StatItem(value: "\(vm.currentUser.totalActivities)", title: "Activities")
                            StatItem(value: "\(Int(vm.currentUser.totalHours))", title: "Hours")
                            StatItem(value: "\(vm.currentUser.points)", title: "Points")
                        }
                        .padding(.top)
                    }
                    
                    // Settings Sections
                    VStack(spacing: 20) {
                        SettingsSection(title: "Account", items: [
                            SettingsItem(icon: "person.fill", title: "Edit Profile", color: .blue),
                            SettingsItem(icon: "bell.fill", title: "Notifications", color: .purple),
                            SettingsItem(icon: "lock.fill", title: "Privacy", color: .green)
                        ])
                        
                        SettingsSection(title: "Preferences", items: [
                            SettingsItem(icon: "gear", title: "Settings", color: .gray),
                            SettingsItem(icon: "questionmark.circle", title: "Help", color: .orange),
                            SettingsItem(icon: "info.circle", title: "About", color: .blue)
                        ])
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                Button("Edit") {
                    isEditingProfile.toggle()
                }
            }
            .sheet(isPresented: $isEditingProfile) {
                EditProfileView(vm: vm)
            }
        }
    }
}

// Existing StatItem, SettingsSection, SettingsItem unchanged from your code...
