//
//  CatFactReamModel.swift
//  Service Locator
//
//  Created by Егор Чирков on 15.11.2022.
//

import Foundation
import RealmSwift

class CatFactRealmModel: Object{
    
    @objc dynamic var id = Int()
    
    @objc dynamic var fact = String()
    
    convenience init(id: Int, fact: String) {
        self.init()
        self.id = id
        self.fact = fact
    }
    
    static func testValue() -> CatFactRealmModel{
        CatFactRealmModel(id: 1, fact: "Cats are animals")
    }
    
    func insert(){
        RealmModelManager.shared.insert(self)
    }
    
    func remove(){
        RealmModelManager.shared.remove(self)
    }
    
}
