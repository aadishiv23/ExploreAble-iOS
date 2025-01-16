//
//  CommunityView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation
import SwiftUI

struct CommunityView: View {
    @StateObject private var vm = CommunityViewModel()
    @Namespace private var animation
    @State private var selectedEvent: GroupEvent?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Featured Event Card
                    if let featuredEvent = vm.upcomingEvents.first {
                        FeaturedEventCard(event: featuredEvent)
                            .transition(.scale.combined(with: .opacity))
                    }
                    
                    // Upcoming Events
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Upcoming Events")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .accessibilityAddTraits(.isHeader)
                        
                        ForEach(vm.upcomingEvents) { event in
                            EventCard(event: event, namespace: animation)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        selectedEvent = event
                                    }
                                }
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Community")
            .sheet(item: $selectedEvent) { event in
                EnhancedEventDetailView(event: event, isPresented: $selectedEvent)
            }
        }
    }
}

struct FeaturedEventCard: View {
    let event: GroupEvent
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Featured Event")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            
            Text(event.title)
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                Label {
                    Text(event.location)
                } icon: {
                    Image(systemName: "mappin.circle.fill")
                }
                .foregroundColor(.secondary)
                
                Spacer()
                
                Label {
                    Text(event.date.formatted(.dateTime.month().day()))
                } icon: {
                    Image(systemName: "calendar")
                }
                .foregroundColor(.secondary)
            }
            
            AccessibilityTagsView(tags: event.accessibilityTags)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme == .dark ? Color(white: 0.15) : .white)
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
}

struct EventCard: View {
    let event: GroupEvent
    let namespace: Namespace.ID
    
    var body: some View {
        HStack(spacing: 16) {
            // Date Circle
            VStack {
                Text(event.date.formatted(.dateTime.month(.abbreviated)))
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(event.date.formatted(.dateTime.day()))
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .frame(width: 60)
            .padding(.vertical, 8)
            .background(
                Circle()
                    .fill(Color.blue.opacity(0.1))
            )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(event.title)
                    .font(.headline)
                    .matchedGeometryEffect(id: "title\(event.id)", in: namespace)
                
                Label {
                    Text(event.location)
                        .lineLimit(1)
                } icon: {
                    Image(systemName: "mappin.circle.fill")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                AccessibilityTagsView(tags: event.accessibilityTags)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(.systemBackground))
                .shadow(radius: 2)
        )
        .padding(.horizontal)
    }
}

struct AccessibilityTagsView: View {
    let tags: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color.blue.opacity(0.1))
                        )
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct EnhancedEventDetailView: View {
    let event: GroupEvent
    @Binding var isPresented: GroupEvent?
    @Environment(\.colorScheme) var colorScheme
    @State private var showJoinConfirmation = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Hero Section
                    VStack(spacing: 16) {
                        Text(event.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        HStack(spacing: 20) {
                            EventDetailItem(
                                icon: "calendar",
                                title: "Date",
                                value: event.date.formatted(.dateTime.month().day().year())
                            )
                            
                            EventDetailItem(
                                icon: "person.3.fill",
                                title: "Participants",
                                value: "\(event.participants)"
                            )
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(colorScheme == .dark ? Color(white: 0.15) : .white)
                            .shadow(radius: 2)
                    )
                    
                    // Location Section
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Location", systemImage: "mappin.circle.fill")
                            .font(.headline)
                        
                        Text(event.location)
                            .font(.body)
                        
                        // Placeholder for map view
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 150)
                            .overlay(
                                Image(systemName: "map")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            )
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(colorScheme == .dark ? Color(white: 0.15) : .white)
                            .shadow(radius: 5)
                    )
                    
                    // Accessibility Features
                    if !event.accessibilityTags.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Label("Accessibility Features", systemImage: "accessibility")
                                .font(.headline)
                            
                            AccessibilityTagsView(tags: event.accessibilityTags)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(colorScheme == .dark ? Color(white: 0.15) : .white)
                                .shadow(radius: 2)
                        )
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(action: {
                    withAnimation {
                        isPresented = nil
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            )
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    showJoinConfirmation = true
                }) {
                    Text("Join Event")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.blue)
                        )
                        .padding()
                }
            }
            .alert("Join Event", isPresented: $showJoinConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Join") {
                    // Join logic here
                }
            } message: {
                Text("Would you like to join \(event.title)?")
            }
        }
    }
}

struct EventDetailItem: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
