//
//  UIImageView+Ext.swift
//  Swiko
//
//  Created by Srijan on 14/06/22.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setImage(with url: URL?, placeHolder: UIImage) {
        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
