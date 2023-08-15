//
//  MainView.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject private var mainViewModel = MainViewModel()
    
    var body: some View {
        NavigationView {
            List(mainViewModel.albums, rowContent: { album in
                AlbumRow(album: album)
            })
            .navigationTitle("Albums")
        }
        .alert(isPresented: $mainViewModel.showError) {
            Alert(
                title: Text("Alert:"),
                message: Text(self.mainViewModel.errorMessage),
                dismissButton: .default(Text("OK")) {}
            )
        }
        .onAppear(perform: { self.mainViewModel.fetch() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

