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
            AppView().environmentObject(delegate)
        }
    }
}

struct AppView:View{
    @EnvironmentObject var delegate:AppDelegate
    var body: some View{
        if(delegate.isAppChannelAvailable){
            if let channel = delegate.appStream {
//                SearchView(channel: channel)
                SplashView()
            }
        }
        else{
            Text("Please Wait while the App is Loading.")
        }
    }
}
