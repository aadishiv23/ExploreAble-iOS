//
//  SearchView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var recentSearches = ["Running", "Yoga", "Adaptive Hiking"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    searchBar
                    recentSearchSection
                    trendingActivitiesSection
                }
            }
            .navigationTitle("Search")
        }
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search activities or users", text: $searchText)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
        .padding(.horizontal)
    }
    
    private var recentSearchSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Recent Searches")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(recentSearches, id: \.self) { search in
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)
                    Text(search)
                    Spacer()
                    Button(action: {
                        // Remove from recent searches
                        if let index = recentSearches.firstIndex(of: search) {
                            recentSearches.remove(at: index)
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
    }
    
    private var trendingActivitiesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Trending")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(["HIIT Workout", "Morning Yoga", "Adaptive Cycling"], id: \.self) { activity in
                HStack {
                    Image(systemName: "flame.fill")
                        .foregroundColor(.orange)
                    Text(activity)
                    Spacer()
                    Text("Join")
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
    }
}
