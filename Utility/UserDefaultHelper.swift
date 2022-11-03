//
//  UserDefaultHelper.swift
//  Swiko
//
//  Created by Vishal.Grover on 08/06/22.
//

import Foundation

enum UserDefaultKeys : String,CaseIterable {
    case token
}

class UserDefaultHelper {
    static func setData<T>(value: T, key: UserDefaultKeys) {
       let defaults = UserDefaults.standard
       defaults.set(value, forKey: key.rawValue)
    }
    static func getData<T>(type: T.Type, forKey: UserDefaultKeys) -> T? {
       let defaults = UserDefaults.standard
       let value = defaults.object(forKey: forKey.rawValue) as? T
       return value
    }
    static func removeData(key: UserDefaultKeys) {
       let defaults = UserDefaults.standard
       defaults.removeObject(forKey: key.rawValue)
    }
}
