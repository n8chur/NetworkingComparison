//
//  AlamofireAPI.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/31/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireAPI {
    private let baseUrl = "http://api.openweathermap.org/data/2.5"
    private var params = [
        "api": Secrets.openWeatherAPIKey,
    ]

    func getForecasts(completion: @escaping (AFResult<[CodableForecast]>) -> Void) {
        // Test using router / URLRequestConvertible
        let request = Router.search(query: "asdf", page: 0)
        AF.request(request).responseJSON { response in
            print(response)
        }
        // Test using standard URLConvertible
        AF.request(baseUrl, parameters: params, encoding: URLEncoding.queryString).responseJSON { response in
            print(response)
        }

        struct Test: Codable {
            let test: Int
        }
        let test = Test(test: 1)

        AF.request(baseUrl, parameters: test, encoder: URLEncodedFormParameterEncoder(destination: .queryString)).responseJSON { response in
            print(response)
        }
    }
}

enum Router: URLRequestConvertible {
    case search(query: String, page: Int)

    static let baseURLString = "https://example.com"
    static let perPage = 50

    // MARK: URLRequestConvertible

    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case let .search(query, page) where page > 0:
                return ("/search", ["q": query, "offset": Router.perPage * page])
            case let .search(query, _):
                return ("/search", ["q": query])
            }
        }()

        let url = try Router.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))

        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}
