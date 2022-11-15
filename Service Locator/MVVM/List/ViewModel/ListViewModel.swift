//
//  ListViewModel.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import Foundation

class ListViewModel: ObservableObject{
    
    @Injected var network: NetworkService?
    
    @Injected var userSettings: UserSettingsService?
    
    @Published var isLoading: Bool = true
    
    @Published private(set) var facts: [String] = []
    
    let localized: Localized = .init()
    
    init(network: NetworkService? = nil, userSettings: UserSettingsService? = nil) {
        self.network = network
        self.userSettings = userSettings
    }
    
    func fetchData(){
        
        let count = userSettings?.valueInt(for: .countFacts) ?? 1
        
        network?.requestData(with: count) { response, errorMsg in
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                guard errorMsg == nil, let response = response else {
                    return
                }
                
                self.facts.removeAll()
                
                self.facts.append(contentsOf: response.data)
            }
        }
    }
    
    func index(for fact: String) -> Int?{
        facts.firstIndex(of: fact)
    }
    
    struct Localized{
        let txtLoading: String = "loading.."
        let txtTitle: String = "Cat Facts"
    }
}
