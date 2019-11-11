//
//  ForecastViewModel.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/25/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import UIKit

protocol ForecastViewModel {
    func refresh(onSuccess: @escaping ([CodableForecast]) -> Void)
}
