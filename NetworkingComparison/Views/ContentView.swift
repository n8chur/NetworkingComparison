//
//  ContentView.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/25/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldShowUrlSessionForecastView = false
    @State private var shouldShowAlamofireForecastView = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 40.0) {
                HStack(spacing: 40.0) {
                    NavigationButton(
                        destination: ForecastView(viewModel: URLSessionViewModel()),
                        isActive: shouldShowUrlSessionForecastView,
                        buttonTitle: "URLSession"
                    )
                    NavigationButton(
                        destination: ForecastView(viewModel: AlamofireViewModel()),
                        isActive: shouldShowAlamofireForecastView,
                        buttonTitle: "Alamofire"
                    )
                }
                Spacer()
            }
            .padding()
            .navigationBarTitle(Text("Networking"))
        }
    }
}

#if DEBUG

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#endif
