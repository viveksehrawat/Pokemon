//
//  MockNetworkManger.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation

@testable import Pokemon

class MockNetworkManager: INetworkManager {
    
    var response: Decodable?
    var error: Error?
    
    func request<T: Decodable>(request: INetworkRequest, responseType: T.Type) async throws -> T where T : Decodable {
        
        if let error = error {
            throw error
        }

        if let response = response {
            return response as! T
        } else {
            throw NetworkError.invalidResponse
        }
    }
}
