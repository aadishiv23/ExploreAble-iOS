//
//  DropdownPicker.swift
//  ExploreAble
//
//  Created by Aadi Shiv Malhotra on 1/21/25.
//

import Foundation
import SwiftUI

/// Enum representing states of our picker.
enum DropDownPickerState {
    case top
    case bottom
}

/// Dropdown picker view
/// From: https://blog.stackademic.com/custom-dropdown-in-swiftui-1e58b5237e6e
struct DropDownPicker: View {

    /// The current selected selection from the dropdown picker.
    @Binding var selection: String?

    /// The state tracking whether the drop down menu should be shown.
    @State var showDropdown: Bool = false

    /// The list of options for values in the picker.
    var options: [String]

    /// Tracks `DropDownPickerState`
    var state: DropDownPickerState = .bottom

    /// Max width of frame.
    var maxWidth: CGFloat = 180

    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0

    var body: some View {
        GeometryReader {
            let size = $0.size
            VStack {
                if state == .top, showDropdown {
                    optionsView
                }

                HStack {
                    Text(selection == nil ? "Select" : selection!)
                        .foregroundStyle(selection == nil ? .black : .gray)

                    Spacer()

                    Image(systemName: state == .top ? "chevron.up" : "chevron.down")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .rotationEffect(.degrees(showDropdown ? -180 : 0))
                }
                .padding(.horizontal, 15)
                .frame(width: 180, height: 50)
                .background(.white)
                .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zindex = index
                    withAnimation(.snappy) {
                        showDropdown.toggle()
                    }
                }

                if state == .bottom, showDropdown {
                    optionsView
                }
            }
            .clipped()
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray)
            }
            .frame(height: size.height, alignment: state == .top ? .bottom : .top)
        }
        .frame(width: maxWidth, height: 50)
        .zIndex(zindex)
    }

    // MARK: Subviews

    private var optionsView: some View {
        VStack {
            ForEach(options, id: \.self) { option in
                HStack {
                    Text(option)
                    Spacer()
                    Image(systemName: "checkmark")
                        .opacity(selection == option ? 1 : 0)
                }
                .foregroundStyle(selection == option ? Color.primary : Color.gray)
                .animation(.none, value: selection)
                .frame(height: 50)
                .contentShape(.rect)
                .padding(.horizontal, 15)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option
                        showDropdown.toggle()
                    }
                }
            }
        }
        .transition(.move(edge: state == .top ? .bottom : .top))
        .zIndex(1)
    }
}

#Preview {
    DropDownContentView()
}

struct DropDownContentView: View {

    @State var selection1: String? = nil

    var body: some View {
        DropDownPicker(
            selection: $selection1,
            options: [
                "Apple",
                "Google",
                "Amazon",
                "Facebook",
                "Instagram"
            ]
        )
    }
}
