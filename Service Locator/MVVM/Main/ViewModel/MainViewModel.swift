//
//  MainViewModel.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import Foundation

class MainViewModel: ObservableObject{
    
    @Published var selection: Int = 0
    
    let localized: Localized = .init()
    
    struct Localized{
        let txtHome: String = "Home"
        let txtSettings: String = "Settings"
    }
}
