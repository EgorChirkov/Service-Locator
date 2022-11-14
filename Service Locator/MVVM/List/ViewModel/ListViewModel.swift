//
//  ListViewModel.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import Foundation

class ListViewModel: ObservableObject{
    
    @Injected var network: NetworkService?
    
    @Published var isLoading: Bool = true
    
    @Published private(set) var facts: [String] = []
    
    init(network: NetworkService? = nil) {
        self.network = network
    }
    
    func fetchData(){
        network?.requestData(with: 5) { response, errorMsg in
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                guard errorMsg == nil, let response = response else {
                    return
                }
                
                self.facts.append(contentsOf: response.data)
            }
        }
    }
}
