//
//  Configurator.swift
//  Service Locator
//
//  Created by Егор Чирков on 13.11.2022.
//

import Foundation

class Configurator{
    
    static let shared: Configurator = .init()
    
    func register(){
        ServiceLocator.shared.addService(service: NetworkService())
        ServiceLocator.shared.addService(service: UserSettingsService())
    }
}
