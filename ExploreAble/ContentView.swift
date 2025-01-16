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
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
        .accentColor(.blue)
    }
}

struct HomeView: View {
    @State private var completedActivities: Int = 5
    @State private var totalActivities: Int = 10
    @State private var selectedActivity: String?
    @State private var showActivitySheet: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Analytics Card
                    VStack(spacing: 15) {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Weekly Progress")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("\(Int((Double(completedActivities) / Double(totalActivities)) * 100))% Complete")
                                    .font(.title2.bold())
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            
                            ZStack {
                                Circle()
                                    .stroke(Color.white.opacity(0.3), lineWidth: 8)
                                Circle()
                                    .trim(from: 0, to: CGFloat(completedActivities) / CGFloat(totalActivities))
                                    .stroke(Color.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                    .rotationEffect(.degrees(-90))
                                Text("\(completedActivities)/\(totalActivities)")
                                    .font(.callout.bold())
                                    .foregroundColor(.white)
                            }
                            .frame(width: 80, height: 80)
                        }
                        .padding()
                    }
                    .background(
                        LinearGradient(colors: [.blue, .purple],
                                     startPoint: .topLeading,
                                     endPoint: .bottomTrailing)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10, x: 0, y: 5)
                    .padding(.horizontal)
                    
                    // Quick Actions
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Quick Start")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(["Running", "Walking", "Cycling"], id: \.self) { activity in
                                    Button {
                                        selectedActivity = activity
                                        showActivitySheet = true
                                    } label: {
                                        VStack {
                                            Circle()
                                                .fill(Color.blue.opacity(0.1))
                                                .frame(width: 60, height: 60)
                                                .overlay(
                                                    Image(systemName: activityIcon(for: activity))
                                                        .font(.title2)
                                                        .foregroundColor(.blue)
                                                )
                                            Text(activity)
                                                .font(.subheadline)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Activities List
                    VStack(alignment: .leading, spacing: 15) {
                        Text("All Activities")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        
                        ForEach(activityOptions, id: \.self) { activity in
                            Button {
                                selectedActivity = activity
                                showActivitySheet = true
                            } label: {
                                ActivityRow(activity: activity)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("ExploreAble")
            .fullScreenCover(item: $selectedActivity) { activity in
                ActivityDetailView(activity: activity)
            }
        }
    }
    
    let activityOptions = ["Running", "Walking", "Cycling", "Swimming", "Hiking", "Yoga", "Gym Workout"]
    
    func activityIcon(for activity: String) -> String {
        switch activity {
        case "Running": return "figure.run"
        case "Walking": return "figure.walk"
        case "Cycling": return "bicycle"
        default: return "figure.walk"
        }
    }
}

// Make String conform to Identifiable for fullScreenCover
extension String: Identifiable {
    public var id: String { self }
}

struct ActivityRow: View {
    let activity: String
    @State private var isPressed: Bool = false
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "figure.run")
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .background(Circle().fill(Color.blue.opacity(0.1)))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(activity)
                    .font(.headline)
                Text("Tap to start")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5, x: 0, y: 2)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3), value: isPressed)
        .onLongPressGesture(minimumDuration: .infinity, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: { })
    }
}

struct SearchView: View {
    @State private var searchText = ""
    @State private var recentSearches = ["Running", "Yoga", "HIIT Training", "Swimming"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search activities or users", text: $searchText)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    
                    // Recent Searches
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
                                    // Remove search
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
                    
                    // Trending Activities
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Trending")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(["HIIT Workout", "Morning Yoga", "5K Run"], id: \.self) { activity in
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
            .navigationTitle("Search")
        }
    }
}

struct ActivitiesView: View {
    @State private var selectedFilter = "All"
    let filters = ["All", "Running", "Cycling", "Yoga", "Gym"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Filter Pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(filters, id: \.self) { filter in
                                Button(action: {
                                    selectedFilter = filter
                                }) {
                                    Text(filter)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .background(
                                            selectedFilter == filter ?
                                            Color.blue :
                                                Color(UIColor.secondarySystemBackground)
                                        )
                                        .foregroundColor(selectedFilter == filter ? .white : .primary)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Activity Cards
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 15) {
                        ForEach(1...6, id: \.self) { index in
                            ActivityCard(
                                title: "Activity \(index)",
                                duration: "\(index * 10) min",
                                participants: "\(index * 5)",
                                color: index % 2 == 0 ? Color.blue : Color.purple
                            )
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Activities")
        }
    }
}

struct ActivityCard: View {
    let title: String
    let duration: String
    let participants: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Circle()
                .fill(color.opacity(0.1))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(systemName: "figure.run")
                        .foregroundColor(color)
                )
            
            Text(title)
                .font(.headline)
            
            HStack {
                Label(duration, systemImage: "clock")
                Spacer()
                Label(participants, systemImage: "person.2")
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
    }
}

struct ProfileView: View {
    @State private var isEditingProfile = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    // Profile Header
                    VStack(spacing: 15) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Circle().fill(Color.blue.opacity(0.1)))
                        
                        VStack(spacing: 5) {
                            Text("John Doe")
                                .font(.title.bold())
                            Text("Fitness Enthusiast")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        // Stats Row
                        HStack(spacing: 30) {
                            StatItem(value: "28", title: "Activities")
                            StatItem(value: "142", title: "Hours")
                            StatItem(value: "8.5k", title: "Points")
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
        }
    }
}

struct StatItem: View {
    let value: String
    let title: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(value)
                .font(.title2.bold())
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct SettingsSection: View {
    let title: String
    let items: [SettingsItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            
            ForEach(items, id: \.title) { item in
                HStack {
                    Image(systemName: item.icon)
                        .foregroundColor(item.color)
                        .frame(width: 30)
                    Text(item.title)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            }
        }
    }
}

struct SettingsItem {
    let icon: String
    let title: String
    let color: Color
}

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

struct TabSelector: View {
    let tabs: [String]
    @Binding var selectedTab: String
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { tab in
                VStack(spacing: 8) {
                    Text(tab)
                        .fontWeight(selectedTab == tab ? .bold : .regular)
                        .foregroundColor(selectedTab == tab ? .primary : .secondary)
                        .padding(.horizontal, 20)
                    
                    ZStack {
                        Capsule()
                            .fill(Color.blue.opacity(0.2))
                            .frame(height: 3)
                        
                        if selectedTab == tab {
                            Capsule()
                                .fill(Color.blue)
                                .frame(height: 3)
                                .matchedGeometryEffect(id: "tab", in: namespace)
                        }
                    }
                }
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                }
            }
        }
    }
    
    @Namespace private var namespace
}

struct StatBox: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
            Text(value)
                .font(.headline)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 100)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
