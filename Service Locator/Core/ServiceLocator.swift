//
//  ServiceLocator.swift
//  Service Locator
//
//  Created by Егор Чирков on 04.11.2022.
//

import Foundation

final class ServiceLocator {

    public static let shared: ServiceLocator = .init()
    
    private lazy var services: Dictionary<String, Any> = [:]
    
    private func typeName(some: Any) -> String{
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    func addService<T>(service: T){
        let key = typeName(some: T.self)
        services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}
