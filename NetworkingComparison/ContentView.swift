//
//  ContentView.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/25/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import SwiftUI

struct URLSessionView: UIViewControllerRepresentable {
    typealias UIViewControllerType = URLSessionViewController

    func updateUIViewController(_ uiViewController: URLSessionViewController, context: UIViewControllerRepresentableContext<URLSessionView>) { }

    func makeUIViewController(context: Context) -> URLSessionViewController {
        return URLSessionViewController()
    }
}

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

struct TestView: UIViewControllerRepresentable {
    typealias UIViewControllerType = TestViewController

    func updateUIViewController(_ uiViewController: TestViewController, context: UIViewControllerRepresentableContext<TestView>) { }

    func makeUIViewController(context: Context) -> TestViewController {
        return TestViewController()
    }
}

struct ContentView: View {
    @State private var isModalVisible = false
    @State private var isTestVisible = false

    var body: some View {
        NavigationView {
            VStack(spacing: 40.0) {
                HStack(spacing: 40.0) {
                    Button(action: {
                        self.isModalVisible = true
                    }) {
                        Text("URLSession")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20.0)
                    .sheet(isPresented: $isModalVisible) {
                        URLSessionView()
                    }

                    Button(action: {
                        self.isTestVisible = true
                    }) {
                        Text("AlamoFire")
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20.0)
                    .sheet(isPresented: $isTestVisible) {
                       TestView()
                    }
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
