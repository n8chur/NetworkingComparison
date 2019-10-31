//
//  API.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/31/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = "http://api.openweathermap.org/data/2.5"

    static let params = [
        "zip": "94110",
        "appid": Secrets.openWeatherAPIKey,
        "units": "imperial",
    ]
}
