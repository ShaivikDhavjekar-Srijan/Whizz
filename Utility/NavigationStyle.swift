//
//  NavigationStyle.swift
//  Swiko
//
//  Created by Jitesh Acharya on 14/06/22.
//

import Foundation
import UIKit

struct NavigationStyle {
    static func setNavBarColor(color:UIColor,isTranslucent:Bool){
        UINavigationBar.appearance().barTintColor = color
        UINavigationBar.appearance().tintColor = UIColor.whiteColor
        UINavigationBar.appearance().isTranslucent = isTranslucent
    }
    
   static func setupNavBar(){
        self.setNavBarColor(color: UIColor.whiteColor, isTranslucent: true)
    }
}
