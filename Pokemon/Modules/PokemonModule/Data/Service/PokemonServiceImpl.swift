//
//  PokemonServiceImpl.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

class PokemonServiceImpl: IPokemonService {
    
    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchPokemonsFromNetwork() async throws -> PokemonResponse{
        let path = "/3/movie/now_playing"
        let request = NetworkRequest(path: path, method: .get)
        do{
            let response = try await networkManager.request(request: request, responseType: PokemonResponse.self)
            return response
        } catch{
            throw error
        }
    }
}
