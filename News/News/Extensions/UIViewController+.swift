//
//  UIViewController+.swift
//  News
//
//  Created by Ceren Güneş on 18.09.2023.
//

import UIKit
import FirebaseAuth

extension UIViewController{
    func handleError(_ error: AuthErrorCode) {
        
        let alert = UIAlertController(title: "Error", message: error.errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OM", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    func showError(_ error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
