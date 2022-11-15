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
    
    @Published var isLoading: Bool = false
    
    @Published private(set) var listItems: [ListRowItem] = []{
        didSet{
            print(listItems.count)
        }
    }
    
    let localized: Localized = .init()
    
    init(network: NetworkService? = nil, userSettings: UserSettingsService? = nil) {
        self.network = network
        self.userSettings = userSettings
    }
    
    func onAppear(){
        guard let isSaved = userSettings?.valueBool(for: .saveList), isSaved else {
            fetchData()
            return
        }

        let localItems = Array(RealmModelManager.shared.fetchObjects(withType: CatFactRealmModel.self))
        
        listItems = localItems.map({ ListRowItem(id: $0.id, text: $0.fact) })
        
        listItems.sort(by: { $0.id < $1.id })
    }
    
    private func fetchData(){
        
        isLoading.toggle()
        
        let count = userSettings?.valueInt(for: .countFacts) ?? 1
        
        network?.requestData(with: count) { response, errorMsg in
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                guard errorMsg == nil, let facts = response?.data else {
                    return
                }
                  
                for fact in facts {
                    self.listItems.append(ListRowItem(id: self.listItems.count, text: fact))
                }
            }
        }
    }
    
    func onSaveList(){
        guard let isSaved = userSettings?.valueBool(for: .saveList), !isSaved else {
            return
        }
        for item in listItems {
            CatFactRealmModel(id: item.id, fact: item.text).insert()
        }
        userSettings?.save(value: true, for: .saveList)
    }
    
    struct Localized{
        let txtLoading: String = "loading.."
        let txtTitle: String = "Cat Facts"
    }
}
