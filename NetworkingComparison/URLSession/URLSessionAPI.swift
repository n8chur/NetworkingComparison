//
//  URLSessionAPI.swift
//  NetworkingComparison
//
//  Created by Ian Luo on 10/25/19.
//  Copyright © 2019 Lokae. All rights reserved.
//

import Foundation

class URLSessionAPI {
    enum APIError: Error {
        case badUrl
        case badRequest(Error)
        case badResponse
    }
    
    private let session = URLSession.shared
    private let baseUrl = "http://api.openweathermap.org/data/2.5"
    private let apiKey = "08b86e7c552789c966a8eee5e99cf18e"
    private var dataTask: URLSessionDataTask?

    func getForecasts(completion: @escaping (Result<[CodableForecast], APIError>) -> Void) {
        guard
            let pathUrl = URL(string: baseUrl)?.appendingPathComponent("forecast"),
            var components = URLComponents(url: pathUrl, resolvingAgainstBaseURL: true)
            else {
                completion(.failure(.badUrl))
                return
        }
        dataTask?.cancel()

        let queryItems = [
            "zip": "94110",
            "appid": apiKey,
            "units": "imperial",
            ]
            .map { URLQueryItem(name: $0, value: $1) }

        components.queryItems = queryItems
        guard let completeUrl = components.url else {
            completion(.failure(.badUrl))
            return
        }
        var request = URLRequest(url: completeUrl)

        dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            defer { self?.dataTask = nil }
            if let error = error {
                completion(.failure(.badRequest(error)))
                return
            }
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                case 200 ..< 300 = response.statusCode
                else {
                    completion(.failure(.badResponse))
                    return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            print(json)
            completion(.success([]))
        }
        dataTask?.resume()
    }
}
