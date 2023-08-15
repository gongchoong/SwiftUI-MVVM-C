//
//  ImageService.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import Foundation
import UIKit
import Combine

class ImageService: ApiServiceProtocol {
    func request<T>(request: T) -> AnyPublisher<T.RequestType, Error> where T: ApiRequestType {
        do {
            guard let url = URL(string: request.url) else { throw ApiError.invalidURL }
            let request = URLRequest(url: url)
            return URLSession.shared.dataTaskPublisher(for: request)
                .retry(1)
                .tryMap {
                    guard let code = ($0.response as? HTTPURLResponse)?.statusCode else {
                        throw ApiError.unknownResponse
                    }
                    guard (200..<300).contains(code) else {
                        throw ApiError.httpError(code: code)
                    }
                    return $0.data as! T.RequestType
                }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<T.RequestType, Error>(error: error).eraseToAnyPublisher()
        } 
    }
}
