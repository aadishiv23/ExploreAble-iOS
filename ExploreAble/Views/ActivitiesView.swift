//
//  ActivitiesView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation
import SwiftUI

struct ActivitiesView: View {
    @StateObject private var vm = ActivitiesViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Filter Pills
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(vm.filters, id: \.self) { filter in
                                Button(action: {
                                    vm.filterBy(filter)
                                }) {
                                    Text(filter)
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 8)
                                        .background(
                                            vm.selectedFilter == filter ?
                                            Color.blue : Color(UIColor.secondarySystemBackground)
                                        )
                                        .foregroundColor(vm.selectedFilter == filter ? .white : .primary)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Activity Cards Grid
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(vm.filteredActivities) { activity in
                            ActivityCard(
                                title: activity.title,
                                duration: activity.duration,
                                participants: activity.participants,
                                color: activity.color
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Button to create group activity
                    NavigationLink(destination: GroupActivityCreationView()) {
                        Text("Create Group Activity")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Activities")
        }
    }
}
