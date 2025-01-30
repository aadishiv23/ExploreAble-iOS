//
//  TabItemsView.swift
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
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
        }
    }
}

import SwiftUI
import AuthenticationServices
import Supabase

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode // For dismissing view if needed// Replace with your Supabase client instance

    var body: some View {
        VStack {
            Text("Search")
                .font(.largeTitle)
                .padding()

            Spacer()

            Button(action: handleSignOut) {
                Text("Sign Out")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding()
        }
    }

    func handleSignOut() {
        Task {
            do {
                // Supabase sign out
                try await supabase.auth.signOut()
                
                // If you're using other credential providers (e.g., Apple), clear them here
                if #available(iOS 13.0, *) {
                    let request = ASAuthorizationAppleIDProvider().createRequest()
                    request.requestedScopes = []
                    let controller = ASAuthorizationController(authorizationRequests: [request])
                    controller.performRequests() // Deauthorize Apple sessions if needed
                }

                print("User signed out successfully")
                // Handle navigation post sign-out, if required
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }
}
