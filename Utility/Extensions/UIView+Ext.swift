//
//  UIView+Ext.swift
//  Swiko
//
//  Created by Srijan on 06/06/22.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    @MainActor func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
          let backgroundView = UIView()
          backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
          backgroundView.backgroundColor = backgroundColor
          backgroundView.tag = 475647
          var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
          activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
          activityIndicator.center = self.center
          activityIndicator.hidesWhenStopped = true
          activityIndicator.style = .medium
          activityIndicator.color = activityColor
          activityIndicator.startAnimating()
          self.isUserInteractionEnabled = false
          backgroundView.addSubview(activityIndicator)
          self.addSubview(backgroundView)
        }
        func activityStopAnimating() {
          if let background = viewWithTag(475647){
            background.removeFromSuperview()
          }
          self.isUserInteractionEnabled = true
        }







}
