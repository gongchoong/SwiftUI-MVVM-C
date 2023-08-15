//
//  MainViewModel.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    private var apiService: ApiServiceProtocol
    private let onAppearSubject = PassthroughSubject<Void, Error>()
    
    @Published var albums: [Album] = []
    @Published var errorMessage = ""
    @Published var showError = false
    
    init(apiService: ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
        fetchAlbums()
    }
    
    func fetch() {
        onAppearSubject.send(())
    }
    
    private func fetchAlbums() {
        let url = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/10/albums.json"
        
        onAppearSubject.flatMap { _ -> AnyPublisher<TopHundredAlbums, Error> in
            return self.apiService.request(request: AlbumRequest(url: url))
        }
        .map { $0.feed.albums }
        .sink(receiveCompletion: { result in
            switch result {
            case .finished:
                break
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.showError.toggle()
            }
        }, receiveValue: { albums in
            self.albums = albums
        }).store(in: &cancellables)
    }
}
