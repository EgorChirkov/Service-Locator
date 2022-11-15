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
    
    func onAppear(){
        guard facts.isEmpty else {
            return
        }
        
        let localItems = Array(RealmModelManager.shared.fetchObjects(withType: CatFactRealmModel.self))
        
        guard !localItems.isEmpty else{
            fetchData()
            return
        }
        
        facts = localItems.map({ $0.fact })
        
        isLoading = false
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
                
                for fact in self.facts {
                    CatFactRealmModel(id: 5, fact: fact).insert()
                }
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
