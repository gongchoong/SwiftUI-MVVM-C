//
//  AlbumImageViewModel.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import Foundation
import SwiftUI
import Combine

class AlbumImageViewModel: ObservableObject {
    private var cancellables: [AnyCancellable] = []
    
    private var onAppearSubject = PassthroughSubject<Void, Error>()
    private let imageService: ApiServiceProtocol
    private let imageUrl: String
    
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var image: UIImage = UIImage()
    
    private let imageSubject = PassthroughSubject<Data, Error>()
    
    init (imageService: ApiServiceProtocol = ImageService(), imageUrl: String) {
        self.imageService = imageService
        self.imageUrl = imageUrl
        
        self.bindOutputs()
    }
    
    func fetch() {
        onAppearSubject.send(())
    }
    
    private func bindOutputs() {
        download(url: imageUrl)
        showImage()
    }
    
    private func download(url: String) {
        onAppearSubject.flatMap { [unowned self] _ in
            self.imageService.request(request: ImageRequest(url: url))
                .catch { error -> Empty<Data, Error> in
                    print(error)
                    return Empty()
                }
        }
        .subscribe(imageSubject)
        .store(in: &cancellables)
    }
    
    private func showImage() {
        imageSubject
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    self?.showError = true
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] data in
                if let image = UIImage(data: data) {
                    self?.image = image
                }
            }).store(in: &cancellables)
    }
}
