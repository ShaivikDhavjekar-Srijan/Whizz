//
//  UIColor+Ext.swift
//  Swiko
//
//  Created by Jitesh Acharya on 09/06/22.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}


extension UIColor {
    static let MidnightBlue = UIColor(hex: "#145DA0")
    static let DarkBlue = UIColor(hex: "#0C2D48")
    static let Blue = UIColor(hex: "#2E8BC0")
    static let BabyBlue = UIColor(hex: "#B1D4E0")
    static let whiteColor = UIColor.white
    static let clearColor = UIColor.clear
}
