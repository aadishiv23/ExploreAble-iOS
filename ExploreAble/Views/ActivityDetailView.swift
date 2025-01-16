//
//  ActivityDetailView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import SwiftUI

struct ActivityDetailView: View {
    let activity: String
    @Environment(\.dismiss) private var dismiss
    @State private var isStarted: Bool = false
    @State private var selectedTab = "Overview"
    let tabs = ["Overview", "Stats", "History"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Hero Section with Background
                    ZStack {
                        Color.blue.opacity(0.1)
                            .ignoresSafeArea()
                            .frame(height: 300)
                        
                        Circle()
                            .fill(Color.white)
                            .frame(height: 200)
                            .overlay(
                                Image(systemName: "figure.run")
                                    .font(.system(size: 80))
                                    .foregroundColor(.blue)
                            )
                            .padding()
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Content Section
                    VStack(spacing: 20) {
                        Text(activity)
                            .font(.title.bold())
                        
                        // Improved Tab Selector
                        TabSelector(tabs: tabs, selectedTab: $selectedTab)
                        
                        // Tab Content
                        TabView(selection: $selectedTab) {
                            overviewTab
                                .tag("Overview")
                            statsTab
                                .tag("Stats")
                            historyTab
                                .tag("History")
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: 400)
                        
                        // Start Button
                        Button {
                            isStarted.toggle()
                        } label: {
                            Text(isStarted ? "End Activity" : "Start Activity")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(isStarted ? Color.red : Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    // Tab content views remain the same but with proper padding
    private var overviewTab: some View {
        VStack(spacing: 20) {
            Text("Get ready for your \(activity.lowercased()) session! This activity helps improve your cardiovascular health and overall fitness.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            HStack(spacing: 30) {
                StatBox(title: "Duration", value: "30 min", icon: "clock")
                StatBox(title: "Calories", value: "150 kcal", icon: "flame")
                StatBox(title: "Distance", value: "2.5 km", icon: "figure.walk")
            }
            .padding(.horizontal)
        }
    }
    
    private var statsTab: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(["Last Week", "Last Month", "Last 3 Months"], id: \.self) { period in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(period)
                            .font(.headline)
                        
                        HStack {
                            StatBox(title: "Sessions", value: "12", icon: "calendar")
                            StatBox(title: "Avg Time", value: "45 min", icon: "clock")
                            StatBox(title: "Total Cal", value: "1.8k", icon: "flame")
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(15)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var historyTab: some View {
        VStack(spacing: 15) {
            ForEach(1...5, id: \.self) { index in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Session \(index)")
                            .font(.headline)
                        Text("\(index) days ago")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("45 min")
                            .font(.subheadline)
                        Text("320 cal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            }
        }
        .padding(.horizontal)
    }
}
