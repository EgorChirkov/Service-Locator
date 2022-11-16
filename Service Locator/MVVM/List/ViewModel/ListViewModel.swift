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
    
    @Published var isSavedState: Bool = false
    
    @Published var isLoading: Bool = false
    
    @Published private(set) var listItems: [ListRowItem] = []{
        didSet{
            debugPrint(listItems.count)
        }
    }
    
    let localized: Localized = .init()
    
    init(network: NetworkService? = nil, userSettings: UserSettingsService? = nil) {
        self.network = network
        self.userSettings = userSettings
    }
    
    func onAppear(){
        guard let isSaved = userSettings?.valueBool(for: .saveList), isSaved else {
            return
        }
        
        isSavedState = true
        
        let localItems = Array(RealmModelManager.shared.fetchObjects(withType: CatFactRealmModel.self))
        
        listItems = localItems.map({ ListRowItem(id: $0.id, text: $0.fact) })
        
        listItems.sort(by: { $0.id < $1.id })
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
    
//    func onClearAll(){
//        listItems.removeAll()
//    }
    
    struct Localized{
        let txtLoading: String = "loading.."
        let txtTitle: String = "Cat Facts"
    }
}

extension ListViewModel {
    
    @MainActor
    func fetchData() async throws {
        let count = userSettings?.valueInt(for: .countFacts) ?? 1
        
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        let facts = try await network?.requestData(with: count)
        
        if let facts = facts{
            for fact in facts{
                listItems.append(ListRowItem(id: listItems.count, text: fact))
            }
        }
    }
}
