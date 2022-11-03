//
//  AppDelegate.swift
//  Swiko
//
//  Created by Sahabe Alam on 25/03/22.
//

import UIKit
import Combine
import IQKeyboardManagerSwift

// @main
class AppDelegate: UIResponder, UIApplicationDelegate, ObservableObject {
    
    var appStream:AppChannel?
    var window: UIWindow?
    var pendingLink = ""
        
    static private(set) var instance: AppDelegate! = nil
    
    @Published private (set) var isAppChannelAvailable:Bool = false
    
    @Published var deepLink:String = ""
    
    
    static func getAppDelegate()->AppDelegate {
        return AppDelegate.instance // UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppDelegate.instance = self
        IQKeyboardManager.shared.enable = true
        Task(){
            let appActor = AppActor()
            appStream = await appActor.run()
            await MainActor.run{
                isAppChannelAvailable = true
            }
            
            
        }
        
        return true
    }
    
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
//    func handleExternalLink(route: String) {
//        
//        //print("rootVC",self.window?.rootViewController)
//        if let rootVC = self.window?.rootViewController  {
//            let controller = rootVC as? UINavigationController
//            guard let presentedVc = controller?.viewControllers.first as? TabViewController else {
//                print("set pending link")
//                pendingLink = route
//                return
//            }
//            pendingLink = ""
//            presentedVc.handleDeepLink(deepLink: route)
//            print("viewcontroller", rootVC)
//        } else {
//            
//            print("set pending link")
//            pendingLink = route
//            
//        }
//        
//        
//        
//    }
    
    
    
    
    
    
    
    
}

