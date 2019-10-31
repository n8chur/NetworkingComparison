//
//  AlamofireViewModel.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/31/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireViewModel: ForecastViewModel {
    let api = AlamofireAPI()

    func refresh(onSuccess: @escaping ([CodableForecast]) -> Void) {
        api.getForecasts { [weak self] result in
            switch result {
            case .success(let forecasts):
                onSuccess(forecasts)
            case .failure(let failure):
                self?.handle(failure: failure)
            }
        }
    }

    private func handle(failure: AFError) {
//        switch failure {
//        case .badResponse:
//            print("bad response")
//        case .badRequest(let error):
//            print(error.localizedDescription)
//        case .badUrl:
//            assertionFailure("bad url")
//        }
    }
}
