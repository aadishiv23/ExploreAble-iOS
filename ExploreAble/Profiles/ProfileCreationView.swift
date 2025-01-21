//
//  ProfileCreationView.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import SwiftUI

/// View for creating a user profile.
struct ProfileCreationView: View {
    /// Binding to indicate whether the user has a profile.
    @Binding var hasProfile: Bool

    @StateObject private var viewModel = ProfileViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                GradientBackground()

                ScrollView {
                    profileImage

                    VStack(spacing: 24) {
                        nameField
                        ageField
                        genderField
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 40)

                    Spacer()

                    createProfileButton
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Create Profile")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .alert("Error", isPresented: .constant(viewModel.error != nil)) {
                Button("OK") { viewModel.error = nil }
            } message: {
                Text(viewModel.error ?? "")
            }
        }
    }

    /// The profile image that is on top of profile creation view. Currently, just an SF Symbol.
    private var profileImage: some View {
        Circle()
            .fill(.white.opacity(0.2))
            .frame(width: 150, height: 150)
            .overlay {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundStyle(.white)
                    .padding(25)
            }
            .padding(.top, 32)
    }

    /// Name field in the form.
    private var nameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField("Enter name here", text: $viewModel.profile.name)
                .textContentType(.name)
                .padding()
                .background(.white.opacity(0.7))
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )
                .foregroundStyle(.white)
        }
    }

    /// Age field in the form.
    private var ageField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Age: \(viewModel.profile.age)")
                .foregroundStyle(.white)
                .font(.headline)
                .fontWeight(.bold)

            HStack {
                Slider(
                    value: Binding(
                        get: { Double(viewModel.profile.age) },
                        set: { viewModel.profile.age = Int($0) }
                    ),
                    in: 13...100,
                    step: 1
                )
                .tint(.white)
            }
            .padding()
            .background(.white.opacity(0.7))
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
        }
    }

    /// Gender field in the form.
    private var genderField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Gender")
                .foregroundStyle(.white)
                .font(.headline)
                .fontWeight(.bold)

            Picker(selection: $viewModel.profile.gender, label: Text(viewModel.profile.gender.isEmpty ? "Select" : viewModel.profile.gender)) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Non-binary").tag("Non-binary")
                Text("Prefer not to say").tag("Prefer not to say")
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color.white.opacity(0.7))
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
        }
    }

    /// Button to create the profile.
    private var createProfileButton: some View {
        Button {
            Task {
                do {
                    try await viewModel.createProfile()
                    hasProfile = true // Update hasProfile to true after successful profile creation
                } catch {
                    print("Error creating profile: \(error)")
                }
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Create Profile")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                viewModel.profile.name.isEmpty || viewModel.profile.gender.isEmpty
                    ? Color.white.opacity(0.3)
                    : Color.white
            )
            .foregroundColor(
                viewModel.profile.name.isEmpty || viewModel.profile.gender.isEmpty
                    ? Color.white.opacity(0.5)
                    : Color(hex: "2E3192")
            )
            .cornerRadius(16)
        }
        .disabled(viewModel.profile.name.isEmpty || viewModel.profile.gender.isEmpty)
        .padding(.horizontal, 24)
        .padding(.bottom, 32)
    }
}


#Preview {
    ProfileCreationView(hasProfile: .constant(false))
}

struct CustomGenderPicker: View {
    @Binding var selectedGender: String
    private let genders = [
        ("male", "Male"),
        ("female", "Female"),
        ("non-binary", "Non-binary"),
        ("undisclosed", "Prefer not to say")
    ]

    var body: some View {
        HStack(spacing: 16) {
            ForEach(genders, id: \.0) { gender in
                Button {
                    selectedGender = gender.0
                } label: {
                    Text(gender.1)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .background(
                            selectedGender == gender.0
                                ? Color.white
                                : Color.white.opacity(0.2)
                        )
                        .foregroundColor(
                            selectedGender == gender.0
                                ? Color(hex: "2E3192")
                                : Color.white
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(selectedGender == gender.0 ? Color.white : Color.clear, lineWidth: 2)
                        )
                }
            }
        }
    }
}
