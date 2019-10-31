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

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 40.0) {
                NavigationLink(
                    destination: URLSessionForecastView().navigationBarTitle("San Francisco"),
                    isActive: $shouldShowUrlSessionForecastView,
                    label: { EmptyView().frame(width: 0, height: 0, alignment: .center) }
                )
                HStack(spacing: 40.0) {
                    Button(action: {
                        self.shouldShowUrlSessionForecastView = true
                    }) {
                        Text("URLSession")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20.0)

                    Button(action: {
                        print("Hello")
                    }) {
                        Text("AlamoFire")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20.0)
                }

                HStack(spacing: 40.0) {
                    Button(action: {
                        print("Hello")
                    }) {
                        Text("RxSwift")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20.0)

                    Button(action: {
                        print("Hello")
                    }) {
                        Text("Combine")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20.0)
                }

                Spacer()
            }
            .foregroundColor(Color.white)
            .font(.title)
            .navigationBarTitle(Text("Networking"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
