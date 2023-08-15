//
//  AlbumView.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import SwiftUI

struct AlbumView: View {
    let album: Album
    
    var body: some View {
        HStack {
            AlbumImageView(albumImageViewModel: AlbumImageViewModel(imageUrl: album.artworkUrl100))
            VStack(alignment: .leading) {
                Text(album.name)
                Text(album.artistName)
            }
            Spacer()
        }
        .contentShape(Rectangle())
        .padding()
    }
}
