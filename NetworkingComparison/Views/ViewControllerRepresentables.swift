//
//  ViewControllerRepresentables.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/31/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import SwiftUI

struct URLSessionForecastView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: ForecastViewController, context: UIViewControllerRepresentableContext<URLSessionForecastView>) { }

    func makeUIViewController(context: Context) -> ForecastViewController {
        return ForecastViewController(viewModel: URLSessionViewModel())
    }
}

struct AlamofireForecastView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: ForecastViewController, context: UIViewControllerRepresentableContext<AlamofireForecastView>) { }

    func makeUIViewController(context: Context) -> ForecastViewController {
        return ForecastViewController(viewModel: AlamofireViewModel())
    }
}
