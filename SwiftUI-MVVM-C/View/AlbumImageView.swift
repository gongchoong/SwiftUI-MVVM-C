//
//  AlbumImageView.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import SwiftUI

struct AlbumImageView: View {
    @ObservedObject private var albumImageViewModel: AlbumImageViewModel
    
    init(albumImageViewModel: AlbumImageViewModel) {
        self.albumImageViewModel = albumImageViewModel
    }
    
    var body: some View {
        Image(uiImage: self.albumImageViewModel.image)
            .frame(width: 75, height: 75, alignment: .center)
            .onAppear(perform: { self.albumImageViewModel.fetch() })
        .padding(.trailing)
    }
}
