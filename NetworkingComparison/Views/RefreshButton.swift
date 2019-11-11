//
//  RefreshButton.swift
//  NetworkingComparison
//
//  Created by Westin Newell on 11/11/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import SwiftUI

struct RefreshButton: View {
    @Binding var isLoading: Bool
    let action: () -> Void

    init(isLoading: Binding<Bool>, action: @escaping () -> Void) {
        self._isLoading = isLoading
        self.action = action
    }

    var body: some View {
        Button(action: action) { Image(systemName: "arrow.clockwise") }
            .rotationEffect(
                isLoading ? .degrees(360) : .degrees(0),
                anchor: UnitPoint(x: 0.5, y: 0.70)
            )
            .animation(isLoading ? repeatForeverAnimation : stopAnimation)
            .disabled(isLoading)
    }

    private var repeatForeverAnimation: Animation {
        Animation.linear(duration: 0.5).repeatForever(autoreverses: false)
    }

    private var stopAnimation: Animation {
        Animation.linear(duration: 0)
    }
}

#if DEBUG

struct DebugRefreshButtonView: View {
    @State var isLoading = false

    var body: some View {
        VStack {
            Toggle(isOn: $isLoading) { EmptyView() }
                .scaledToFit()

            RefreshButton(isLoading: $isLoading) {}
        }.onAppear() { self.isLoading = true }
    }
}

struct RefreshButton_Previews: PreviewProvider {
    @State var isLoading = false

    static var previews: some View {
        NavigationView {
            DebugRefreshButtonView()
        }
    }
}

#endif
