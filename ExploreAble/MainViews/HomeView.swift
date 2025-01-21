//
//  HomeView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/20/25.
//

import Foundation
import SwiftUI

struct HomeView: View {

    // MARK: Properties

    @StateObject private var viewModel = HomeViewModel()

    // MARK: Body

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 15) {
                    dailyUpdateCard
                    quickStartSection
                }
            }
            .navigationTitle("ExploreAble")
        }
    }

    // MARK: Subviews

    private var dailyUpdateCard: some View {
        DailyUpdateCardView()
    }
    
    private var quickStartSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Recent")
                .font(.title3.bold())
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.activityOptions, id: \.self) { activity in
                        Button {
                            viewModel.selectActivity(activity)
                        } label: {
                            QuickStartCardView(
                                activity: activity,
                                icon: activityIcon(for: activity),
                                action: {
                                    viewModel.selectActivity(activity)
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: Private Functions
    
    /// Utility for icons
    private func activityIcon(for activity: String) -> String {
        switch activity {
        case "Running": "figure.run"
        case "Walking": "figure.walk"
        case "Cycling": "bicycle"
        default: "figure.walk"
        }
    }
}

#Preview {
    HomeView()
}
