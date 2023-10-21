//
//  PokemonRepository.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

class PokemonRepositoryImpl: IPokemonRepository {
   
    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchPokemonsFromNetwork() async throws -> PokemonPage{
        let path = "/api/v2/pokemon"
        let request = NetworkRequest(path: path, method: .get)
        do{
            let response = try await networkManager.request(request: request, responseType: PokemonListDTO.self)
            return response.toDomain()
        } catch{
            throw error
        }
    }
    
}
