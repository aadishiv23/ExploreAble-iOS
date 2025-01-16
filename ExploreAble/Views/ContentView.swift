//
//  ContentView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            ActivitiesView()
                .tabItem {
                    Label("Activities", systemImage: "figure.run")
                }
            
            CommunityView()
                .tabItem {
                    Label("Community", systemImage: "person.2.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
        // If using custom accent color
        .accentColor(.blue)
    }
}
