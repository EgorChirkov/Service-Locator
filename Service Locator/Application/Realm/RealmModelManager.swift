//
//  RealmModelManager.swift
//  Service Locator
//
//  Created by Егор Чирков on 15.11.2022.
//

import Foundation
import RealmSwift

class RealmModelManager{
    
    static let shared: RealmModelManager = .init()
    
    private let realmPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/catfacts.realm"
    
    private init() {}
    
    func realmConfiguration(){
        Realm.Configuration.defaultConfiguration =
        Realm.Configuration(
            fileURL: URL(fileURLWithPath: realmPath),
            schemaVersion: 1)
    }
    
    func insert<T : Object>(_ object: T){
        let realm = try! Realm()
        try? realm.write {
            realm.add(object)
        }
    }
    
    func remove<T : Object>(_ object: T){
        let realm = try! Realm()
        try? realm.write {
            realm.delete(object)
        }
    }
    
    func fetchObjects<T : Object>(withType type: T.Type) -> Results<T>{
        let realm = try! Realm()
        return realm.objects(type).sorted(byKeyPath: "id", ascending: false)
    }
}
