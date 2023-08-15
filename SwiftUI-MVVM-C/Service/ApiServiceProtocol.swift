//
//  ApiServiceProtocol.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import Foundation
import Combine

enum ApiError: Error {
    case invalidURL
    case unknownResponse
    case decodingError
    case httpError(code: Int)
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .unknownResponse:
            return "Unknown response received"
        case .decodingError:
            return "Decoding error"
        case .httpError(code: let code):
            return "HTTP Error: \(code)"
        }
    }
}

protocol ApiServiceProtocol {
    func request<T>(request: T) -> AnyPublisher<T.RequestType, Error> where T: ApiRequestType
}
