//
//  VisualEffects.swift
//  Swiko
//
//  Created by Shaivik Dhavjekar on 27/09/22.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct LoadingView: View {
    var tintColor: Color = .black
    var scaleSize: CGFloat = 1.0
    
    var body: some View {
        ZStack{
            VisualEffectView(effect: UIBlurEffect(style: .regular))
                .edgesIgnoringSafeArea(.all)
            ProgressView()
                .scaleEffect(scaleSize, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: tintColor))
        }
        
    }
}
