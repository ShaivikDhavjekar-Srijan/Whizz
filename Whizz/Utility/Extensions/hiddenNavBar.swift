//
//  hiddenNavBar.swift
//  Whizz
//
//  Created by Akarsha Mandrekar on 04/11/22.
//


import Foundation
import SwiftUI

//ViewModifiers.swift

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}
