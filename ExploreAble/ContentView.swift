//
//  ContentView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import SwiftUI

struct TabItemsView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            SearchView()
                .tabItem(<#T##label: () -> View##() -> View#>) {
                    Label("Search", systemImage: "magnifyingglass" chatGPT)
                }
            
        }
    }
}

struct HomeView: View {
    var body: some View {
        Text("hello world")
    }
}

struct SearchView: View {
    var body: some View {
        Text("search")
    }
}

