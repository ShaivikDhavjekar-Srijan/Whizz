//
//  CommonMethods.swift
//  Swiko
//
//  Created by Vishal.Grover on 09/06/22.
//

import Foundation
import UIKit

class CommonMethods {
    static func getAttributedString(text:String, font:UIFont = UIFont.systemFont(ofSize: 16.0, weight: .regular), color:UIColor = UIColor.black) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .paragraphStyle: paragraphStyle
        ]
        let attString = NSMutableAttributedString(string: text)
        attString.addAttributes(attributes, range: (text as NSString).range(of: text))
        return attString
    }
    
    static func getUnderLineAttributedString(text:String, underLineText:String, attributeFont:UIFont? = nil, attributeName:String? = nil, font:UIFont = UIFont.systemFont(ofSize: 16.0, weight: .regular), color:UIColor = UIColor.black) -> NSMutableAttributedString {
        let attString = CommonMethods.getAttributedString(text: text, font: font, color: color)
        let range1 = (text as NSString).range(of: underLineText)
        attString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range1)
        if attributeFont != nil {
            attString.addAttribute(NSAttributedString.Key.font, value: attributeFont!, range: range1)
        }
        if attributeName != nil {
            attString.addAttribute(NSAttributedString.Key.link, value: attributeName!, range: range1)
        }
        return attString
    }
}
