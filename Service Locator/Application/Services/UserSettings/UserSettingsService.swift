//
//  UserSettingsService.swift
//  Service Locator
//
//  Created by Егор Чирков on 15.11.2022.
//

import Foundation

enum UserKey: String{
    case countFacts = "countFacts"
}

class UserSettingsService{
    
    func save(value: Int, for key: UserKey){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func valueInt(for key: UserKey) -> Int{
        UserDefaults.standard.integer(forKey: key.rawValue)
    }
}
