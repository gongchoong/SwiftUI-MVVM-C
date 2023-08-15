//
//  ApiRequestType.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import Foundation

protocol ApiRequestType {
    associatedtype RequestType: Decodable
    
    var url: String {get}
}

struct AlbumRequest: ApiRequestType {
    typealias RequestType = TopHundredAlbums
    
    var url: String
}

struct ImageRequest: ApiRequestType {
    typealias RequestType = Data
    
    var url: String
}
