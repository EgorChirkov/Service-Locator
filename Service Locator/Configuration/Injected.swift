//
//  Injected.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    
    private var service: T? = nil
    
    private weak var serviceManager = ServiceLocator.shared
    
    public init(){}
    
    public var wrappedValue: T? {
        mutating get {
            if self.service == nil{
                self.service = serviceManager?.getService()
            }
            return service
        }
        mutating set {
            service = newValue
        }
    }
    
    public var projectedValue: Injected<T>{
        get {
            return self
        }
        mutating set {
            self = newValue
        }
    }
}
