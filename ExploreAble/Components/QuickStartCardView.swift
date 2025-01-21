//
//  QuickStartCardView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation
import SwiftUI

struct QuickStartCardView: View {

    // MARK: Properties

    let activity: String
    let icon: String
    let action: () -> Void

    // MARK: Body

    var body: some View {
        Button(action: action) {
            VStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 60, height: 60)
                    .overlay {
                        Image(systemName: icon)
                            .font(.title2)
                            .foregroundStyle(.blue)
                    }
                
                Text(activity)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    QuickStartCardView(activity: "Running", icon: "figure.run") {
        print("Activity selected")
    }
}

