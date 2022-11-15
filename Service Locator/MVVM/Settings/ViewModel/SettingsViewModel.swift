//
//  SettingsViewModel.swift
//  Service Locator
//
//  Created by Егор Чирков on 15.11.2022.
//

import Foundation
import Combine

enum ActionType{
    case up
    case down
}

class SettingsViewModel: ObservableObject{
    
    @Injected var userSettings: UserSettingsService?
    
    @Published var countFacts = 1
    
    @Published var isDownDisabled: Bool = false
    
    @Published var isUpDisabled: Bool = false
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(userSettings: UserSettingsService? = nil) {
        self.userSettings = userSettings
    }
    
    let localized: Localized = .init()
    
    func onAppear(){
        countFacts = userSettings?.valueInt(for: .countFacts) ?? 1
        setupBindings()
    }
    
    func onDisappear(){
        removeBindings()
    }
    
    func onAction(_ actionType: ActionType){
        switch actionType{
        case .down:
            countFacts-=1
        case .up:
            countFacts+=1
        }
    }
    
    private func setupBindings(){
        $countFacts
            .debounce(for: .seconds(0.1), scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
                
                guard let self = self else {
                    return
                }
                
                newValue == 1 ? (self.isDownDisabled = true) : (self.isDownDisabled = false)
                
                newValue == 10 ? (self.isUpDisabled = true) : (self.isUpDisabled = false)

                self.userSettings?.save(value: newValue, for: .countFacts)
            }
            .store(in: &cancellable)
    }
    
    private func removeBindings(){
        cancellable.forEach{
            $0.cancel()
        }
        cancellable.removeAll()
    }
    
    struct Localized{
        let txtCount: String = "Select count"
        let txtSettings: String = "Settings"
    }
}
