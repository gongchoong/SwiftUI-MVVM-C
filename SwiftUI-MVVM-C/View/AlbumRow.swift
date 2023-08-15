//
//  AlbumRow.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import SwiftUI

struct AlbumRow: View {
    let album: Album
    
    var body: some View {
        NavigationLink {
            WebView(url: album.url)
        } label: {
            AlbumView(album: album)
        }
        .buttonStyle(PlainButtonStyle())

    }
}
