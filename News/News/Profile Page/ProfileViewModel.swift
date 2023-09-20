//
//  ProfileViewModel.swift
//  News
//
//  Created by Ceren Güneş on 19.09.2023.
//

import FirebaseAuth
import UIKit

final class ProfileViewModel {
    
    func switchToDarkMode(sender: UISwitch) -> String {
        var labelText: String
        let appDelegate = UIApplication.shared.windows.first
        if sender.isOn {
            appDelegate?.overrideUserInterfaceStyle = .dark
            labelText = "Dark Mode"
        }
        else{
            appDelegate?.overrideUserInterfaceStyle = .light
            labelText = "Light Mode"
        }
        
        return labelText
    }
}
