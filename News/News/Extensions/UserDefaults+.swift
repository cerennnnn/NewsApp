//
//  UserDefaults+.swift
//  News
//
//  Created by Ceren Güneş on 17.09.2023.
//

import Foundation

extension UserDefaults {
    private enum UserDefaultsKey: String {
        case hasOnboarded
    }
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultsKey.hasOnboarded.rawValue)
        }
        
        set {
            setValue(newValue, forKey: UserDefaultsKey.hasOnboarded.rawValue)
        }
    }
}
