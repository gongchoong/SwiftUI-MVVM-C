//
//  TopHundredAlbums.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import Foundation

struct TopHundredAlbums: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let albums: [Album]
    
    enum CodingKeys: String, CodingKey {
        case title
        case albums = "results"
    }
}

struct Album: Codable, Identifiable {
    let id: String
    let artistName: String
    let name: String
    let artworkUrl100: String
    let artistId: String?
    let releaseDate: String
    let artistUrl: String?
    let url: String
    let genres: [Genre]
}

struct Genre: Codable {
    let genreId: String
    let name: String
    let url: String
    
}
