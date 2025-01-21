//
//  SignInView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @StateObject private var authManager = AuthManager.shared
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "2E3192"),
                    Color(hex: "1BFFFF")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // App logo/icon
                Image(systemName: "globe")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                
                // Welcome text
                VStack(spacing: 10) {
                    Text("Welcome to")
                        .font(.title2)
                        .foregroundColor(.white)
                    Text("ExploreAble")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                // Sign in with Apple button
                SignInWithAppleButton { request in
                    request.requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        handleSignIn(authorization)
                    case .failure(let error):
                        print("Sign in error: \(error)")
                    }
                }
                .signInWithAppleButtonStyle(
                    colorScheme == .dark ? .white : .black
                )
                .frame(height: 50)
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding(.top, 100)
        }
    }
    
    private func handleSignIn(_ authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            guard let identityToken = appleIDCredential.identityToken,
                  let idToken = String(data: identityToken, encoding: .utf8) else {
                print("Unable to retrieve identity token.")
                return
            }

            // Extract full name
            let fullName = [
                appleIDCredential.fullName?.givenName,
                appleIDCredential.fullName?.familyName
            ]
            .compactMap { $0 }
            .joined(separator: " ")

            Task {
                do {
                    // Sign in with Apple using Supabase
                    let authResponse = try await supabase.auth.signInWithIdToken(
                        credentials: .init(provider: .apple, idToken: idToken)
                    )

                  

                    // Update full name in Supabase if available
//                    if !fullName.isEmpty {
//                        try await supabase
//                            .from("profiles")
//                            .update(["full_name": fullName])
//                            .eq("id", value: authResponse.user.id)
//                            .execute()
//                    }

                    // Update authentication state in AuthManager
                    DispatchQueue.main.async {
                        authManager.isAuthenticated = true
                    }
                } catch {
                    print("Error during Apple sign-in: \(error)")
                }
            }
        default:
            print("Unexpected authorization credential type.")
        }
    }

}
