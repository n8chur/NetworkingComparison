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
    static let shared = AlamofireAPI()

    private enum RequestStyle {
        case router, params, encodable
    }

    private var requestStyle: RequestStyle = .router

    func getForecasts(completion: @escaping (AFResult<[CodableForecast]>) -> Void) {
        switch requestStyle {
        case .router: requestWithRouter(completion)
        case .params: requestWithParams(completion)
        case .encodable: requestWithEncodable(completion)
        }
    }

    private func requestWithRouter(_ completion: @escaping (AFResult<[CodableForecast]>) -> Void) {
        print("********** Alamofire requesting with URLRequestConvertible Router **********")

        let request = Router.forecast
        AF.request(request).responseJSON { [weak self] response in
            print(response)
            self?.requestStyle = .params
        }
    }

    private func requestWithParams(_ completion: @escaping (AFResult<[CodableForecast]>) -> Void) {
        print("********** Alamofire requesting with URLConvertible and Parameter Dictionary **********")

        let request = AF.request(API.baseUrl, parameters: API.params, encoding: URLEncoding.queryString)
        request.responseJSON { [weak self] response in
            print(response)
            self?.requestStyle = .encodable
        }
    }

    private func requestWithEncodable(_ completion: @escaping (AFResult<[CodableForecast]>) -> Void) {
        print("********** Alamofire requesting with URLConvertible and Encodable parameter model **********")

        struct Params: Codable {
            let zipCode: String
            let appId: String
            let units: String

            private enum CodingKeys: String, CodingKey {
                case zipCode = "zip"
                case appId = "appid"
                case units
            }
        }
        guard let zip = API.params["zip"], let appId = API.params["appid"], let units = API.params["units"] else {
            fatalError("Invalid param keys")
        }
        let encodableParams = Params(zipCode: zip, appId: appId, units: units)

        let request = AF.request(
            API.baseUrl,
            parameters: encodableParams,
            encoder: URLEncodedFormParameterEncoder(destination: .queryString)
        )
        request.responseJSON { [weak self] response in
            print(response)
            self?.requestStyle = .router
        }
    }
}

enum Router: URLRequestConvertible {
    case forecast

    func asURLRequest() throws -> URLRequest {
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case .forecast:
                return ("/forecast", API.params)
            }
        }()

        let url = try API.baseUrl.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))

        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
}
