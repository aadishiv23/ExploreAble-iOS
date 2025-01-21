//
//  DailyUpdateCardView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation
import SwiftUI

//
//  DailyUpdateCardView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation
import SwiftUI

/// A card view displaying the user's daily progress and next scheduled activity.
struct DailyUpdateCardView: View {

    // MARK: - Environment

    @Environment(\.colorScheme) var colorScheme

    // MARK: - Body

    var body: some View {
        VStack(spacing: 15) {
            headerSection
            Divider()
                .background(Color.white.opacity(0.6))
            nextActivitySection
        }
        .padding()
        .background(cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .shadow(radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }

    // MARK: - Private Views

    /// Header section displaying progress and a circular progress bar.
    private var headerSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Weekly Progress")
                    .font(.headline)
                    .foregroundStyle(.white)

                Text("10% Complete")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
            }

            Spacer()

            progressCircle
        }
    }

    /// A circular progress indicator with the current progress percentage.
    private var progressCircle: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.3), lineWidth: 8)
            Circle()
                .trim(from: 0, to: CGFloat(10) / CGFloat(100)) // 10% progress
                .stroke(Color.white, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text("\(10)/\(100)") // Progress text
                .font(.callout.bold())
                .foregroundColor(.white)
        }
        .frame(width: 80, height: 80)
    }

    /// Section displaying the next activity and its scheduled time.
    private var nextActivitySection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Next Up")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))

                Text("Meditating")
                    .font(.headline)
                    .foregroundStyle(.white)
            }

            Spacer()

            Text("Friday, 10:00 AM")
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }

    /// Background gradient for the card.
    private var cardBackground: some View {
        LinearGradient(
            colors: [.blue, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    DailyUpdateCardView()
}
