//
//  HomeView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/15/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    weeklyProgressCard
                    quickStartSection
                    socialFeedSection
                    activityListSection
                }
                .padding(.vertical)
            }
            .navigationTitle("ExploreAble")
            .sheet(isPresented: $vm.showWeeklyDetail) {
                WeeklyDetailView()
            }
            .sheet(item: $vm.selectedPost) { post in
                PostDetailView(post: post)
            }
            .sheet(isPresented: $vm.showActivitySheet) {
                if let activity = vm.selectedActivity {
                    ActivityDetailView(activity: activity)
                }
            }
        }
    }

    // MARK: - Subviews

    private var weeklyProgressCard: some View {
        Button {
            vm.showWeeklyDetail = true
        } label: {
            VStack(spacing: 15) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Weekly Progress")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("\(vm.progressPercentage)% Complete")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(Color.white.opacity(0.3), lineWidth: 8)
                        Circle()
                            .trim(from: 0, to: CGFloat(vm.completedActivities) / CGFloat(vm.totalActivities))
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                        Text("\(vm.completedActivities)/\(vm.totalActivities)")
                            .font(.callout.bold())
                            .foregroundColor(.white)
                    }
                    .frame(width: 80, height: 80)
                }

                Divider()
                    .background(Color.white.opacity(0.3))

                // Next Activity
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Next Up")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        Text(vm.nextScheduledActivity.name)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text(vm.nextScheduledActivity.time, style: .time)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }

                // Quick Analytics
                HStack {
                    ForEach(vm.analyticsData, id: \.label) { item in
                        VStack(spacing: 4) {
                            Text(item.value)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(item.label)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        if item.label != vm.analyticsData.last?.label {
                            Spacer()
                        }
                    }
                }
            }
            .padding()
            .background(
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 10, x: 0, y: 5)
            .padding(.horizontal)
        }
    }

    private var socialFeedSection: some View {
        VStack(spacing: 15) {
            ForEach(vm.posts) { post in
                PostCard(post: post, onLike: {
                    vm.toggleLike(for: post)
                }, onTap: {
                    vm.selectedPost = post
                })
            }
        }
        .padding(.horizontal)
    }

    // Keep existing quickStartSection implementation

    private var quickStartSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Quick Start")
                .font(.title3.bold())
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(vm.activityOptions, id: \.self) { activity in
                        Button {
                            vm.selectActivity(activity)
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
    }

    private var activityListSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("All Activities")
                .font(.title3.bold())
                .padding(.horizontal)

            ForEach(vm.activityOptions, id: \.self) { activity in
                Button {
                    vm.selectActivity(activity)
                } label: {
                    ActivityRow(activity: activity)
                }
            }
        }
        .padding(.horizontal)
    }

    /// Utility for icons
    func activityIcon(for activity: String) -> String {
        switch activity {
        case "Running": "figure.run"
        case "Walking": "figure.walk"
        case "Cycling": "bicycle"
        default: "figure.walk"
        }
    }
}

struct PostCard: View {
    let post: Post
    let onLike: () -> Void
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 12) {
                // Header
                HStack {
                    Image(systemName: post.profileImage)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        Text(post.author)
                            .font(.headline)
                        Text(post.timestamp, style: .relative)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }

                // Content
                Text(post.content)
                    .font(.body)
                    .multilineTextAlignment(.leading)

                if let mediaType = post.mediaType {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .overlay(
                            Image(systemName: mediaType == .image ? "photo" : "video")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                        )
                }

                // Footer
                HStack(spacing: 20) {
                    Button(action: onLike) {
                        HStack {
                            Image(systemName: post.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(post.isLiked ? .red : .primary)
                            Text("\(post.likes)")
                        }
                    }

                    HStack {
                        Image(systemName: "bubble.right")
                        Text("\(post.comments.count)")
                    }
                }
                .foregroundColor(.primary)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(15)
            .shadow(radius: 5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

/// Additional Views (implement these as needed)
struct WeeklyDetailView: View {
    var body: some View {
        Text("Weekly Detail View")
    }
}

struct PostDetailView: View {
    let post: Post

    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                PostCard(post: post, onLike: {}, onTap: {})
                    .padding(.horizontal)

                Divider()

                ForEach(post.comments) { comment in
                    CommentRow(comment: comment)
                }
            }
        }
    }
}

struct CommentRow: View {
    let comment: Comment

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: comment.profileImage)
                .resizable()
                .frame(width: 30, height: 30)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(comment.author)
                    .font(.headline)
                Text(comment.content)
                    .font(.body)
                Text(comment.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}
