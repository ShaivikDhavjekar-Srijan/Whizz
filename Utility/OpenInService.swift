//
//  OpenInService.swift
//  Swiko
//
//  Created by Jitesh Acharya on 14/06/22.
//

import Foundation
import UIKit

class OpenInService {
    
    static func OpenUrlInSafari(strURL: String) -> Bool {
        
        if let url = URL(string: strURL),UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options:[:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            return true
        }
        return false
    }
}
