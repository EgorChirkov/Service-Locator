//
//  NetworkService.swift
//  Service Locator
//
//  Created by Егор Чирков on 13.11.2022.
//

import Foundation

enum NetworkError: Error {
    case failedCreateUrl
    case badStatusResponse
    case notJsonDecode
    
}

struct ResponseCatFacts: Decodable{
    var data: [String]
}

class NetworkService {
    
    private var api_str: String = "https://meowfacts.herokuapp.com/?count=%i"
    
    func requestData(with count: Int = 1, completionRequest: @escaping (_ response: ResponseCatFacts?, _ errorMsg: String?) -> Void){
        guard let url = URL(string: String(format: api_str, count)) else {
            completionRequest(nil, "NetworkService: error create url")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else{
                completionRequest(nil, error?.localizedDescription)
                return
            }
            
            guard let data = data, let json = try? JSONDecoder().decode(ResponseCatFacts.self, from: data) else {
                completionRequest(nil, "NetworkService: not json decode")
                return
            }
            
            completionRequest(json, nil)
            
        }.resume()
    }
    
    func requestData(with count: Int = 1) async throws -> [String]{
        
        guard let url = URL(string: String(format: api_str, count)) else {
            throw NetworkError.failedCreateUrl
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
            throw NetworkError.badStatusResponse
        }
        
        guard let responseCatFacts = try? JSONDecoder().decode(ResponseCatFacts.self, from: data) else {
            throw NetworkError.notJsonDecode
        }
        
        return responseCatFacts.data
        
    }
}
