//
//  ContentView.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/25/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isUrlSessionModalVisible = false

    var body: some View {
        NavigationView {
            VStack(spacing: 40.0) {
                HStack(spacing: 40.0) {
                    Button(action: {
                        self.isUrlSessionModalVisible = true
                    }) {
                        Text("URLSession")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20.0)
                    .sheet(isPresented: $isUrlSessionModalVisible) {
                        URLSessionView()
                    }

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
            }
            .foregroundColor(Color.white)
            .font(.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
