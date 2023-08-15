//
//  WebView.swift
//  SwiftUI-MVVM-C
//
//  Created by David Lee on 8/15/23.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
 
    var url: String
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: self.url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
