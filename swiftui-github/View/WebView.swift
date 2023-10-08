//
//  WebView.swift
//  swiftui-github
//
//  Created by Ciko Edo Febrian on 08/10/23.
//

import Foundation
import WebKit
import SwiftUI


struct WebView: UIViewRepresentable {

    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
