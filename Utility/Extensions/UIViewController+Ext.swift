//
//  UIViewController+Ext.swift
//  Swiko
//
//  Created by Srijan on 06/06/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Show a basic alert
    @MainActor func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //Add more actions as you see fit
        self.present(alert, animated: true, completion: nil)
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
    
    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func navigateToPreviousController() {
        self.navigationController?.popViewController(animated: true)
    }
    
   @objc  func navigateToRootController() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func embeded(in nav: UINavigationController? = nil) -> UINavigationController {
      if let nav = nav {
        nav.setViewControllers([self], animated: false)
        return nav
      } else {
        let nav = UINavigationController(rootViewController: self)
        nav.isNavigationBarHidden = true
        //nav.navigationBar.isTranslucent = true
        //nav.navigationBar.barTintColor = .white
        return nav
      }
    }
    
}
