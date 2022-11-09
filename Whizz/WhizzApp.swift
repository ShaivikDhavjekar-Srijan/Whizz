//
//  WhizzApp.swift
//  Whizz
//
//  Created by Jitesh Acharya on 02/11/22.
//

import SwiftUI

@main
struct WhizzApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            SplashView().environmentObject(delegate)
        }
    }
}
