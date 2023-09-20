//
//  ProfileViewModel.swift
//  News
//
//  Created by Ceren Güneş on 19.09.2023.
//

import FirebaseAuth
import UIKit

final class ProfileViewModel {
    
    func getEmail() -> String {
        if let user = Auth.auth().currentUser {
            if let email = user.email {
                return email
            } else {
                return "User do not logged in."
            }
        } else {
            return "User do not sign up."
        }
    }
    
    func darkModeButtonTapped(_ sender: UISwitch) -> String {
        let appDelegate = UIApplication.shared.windows.first
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: "DarkModeEnabled")
        
        if sender.isOn {
            if isDarkModeEnabled {
                UserDefaults.standard.set(false, forKey: "DarkModeEnabled")
                appDelegate?.overrideUserInterfaceStyle = .dark
                return "Dark Mode"
            } else {
                // Dark Mode kapalı, gerekli tasarımı uygula
                UserDefaults.standard.set(true, forKey: "DarkModeEnabled")
                appDelegate?.overrideUserInterfaceStyle = .light
                return "Light Mode"
            }
        } else {
            UserDefaults.standard.set(false, forKey: "DarkModeEnabled")
            appDelegate?.overrideUserInterfaceStyle = .dark
            return "Dark Mode"
        }
    }
}
