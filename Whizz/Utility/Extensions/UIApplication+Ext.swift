//
//  UIApplication+Ext.swift
//  Swiko
//
//  Created by Kartik.Saraf on 23/09/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
