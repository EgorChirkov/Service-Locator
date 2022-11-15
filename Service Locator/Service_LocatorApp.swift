//
//  Service_LocatorApp.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import SwiftUI

@main
struct Service_LocatorApp: App {
    
    init(){
        Configurator.shared.register()
        
        RealmModelManager.shared.realmConfiguration()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
