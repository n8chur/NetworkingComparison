//
//  ForecastView.swift
//  NetworkingComparison
//
//  Created by Westin Newell on 11/11/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import SwiftUI

struct ForecastView: View {
    @State var forecasts: [CodableForecast] = []
    @State var isLoading = false

    private let viewModel: ForecastViewModel

    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(forecasts) { forecast in
            VStack {
                Text(forecast.formattedDate).font(.headline)
                Text(forecast.formattedDescription).font(.callout)
            }
        }
            .navigationBarItems(trailing: refreshButton)
            .onAppear() { self.refresh() }
    }

    var refreshButton: some View {
        RefreshButton(isLoading: $isLoading) { self.refresh() }
    }

    func refresh() {
        guard !isLoading else { return }

        isLoading = true

        self.viewModel.refresh { forecasts in
            self.forecasts = forecasts

            self.isLoading = false
        }
    }
}


#if DEBUG

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ForecastView(viewModel: AlamofireViewModel())
                .navigationBarTitle("San Francisco", displayMode: .inline)
        }
    }
}

#endif
