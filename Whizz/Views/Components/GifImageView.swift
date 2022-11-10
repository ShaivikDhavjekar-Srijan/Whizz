//
//  GifImageView.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 07/11/22.
//

import SwiftUI
import WebKit

struct GifImageView: UIViewRepresentable {
    private let name: String
    
    init(_ name: String){
        self.name = name
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        
        webView.scrollView.isScrollEnabled = false
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
    
    typealias UIViewType = WKWebView
}

//struct GifImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        GifImageView("HomeViewGif")
//    }
//}
