//
//  PokemonDetailRepository.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation

class PokemonDetailRepositoryImpl: IPokemonDetailRepository {
    
    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchPokemonDetail(for name: String) async throws -> PokemonDetail {
        let path = "/api/v2/pokemon/\(name)"
        let request = NetworkRequest(path: path, method: .get)
        do{
            let response = try await networkManager.request(request: request, responseType: PokemonDetailDTO.self)
            return response.toDomain()
        } catch{
            throw error
        }
    }
    
    func fetchPokemonDescription(for id: Int) async throws -> PokemonDescription {

        let path = "/api/v2/pokemon-species/\(id)"
        let request = NetworkRequest(path: path, method: .get)
        do{
            let response = try await networkManager.request(request: request, responseType: PokemonDescriptionDTO.self)
            return response.toDomain()
        } catch{
            throw error
        }
    }
    
    func fetchPokemonWeakness(for value: Int) async throws -> PokemonWeakness {
        let path = "/api/v2/type/\(value)"
        let request = NetworkRequest(path: path, method: .get)
        do{
            let response = try await networkManager.request(request: request, responseType: PokemonWeaknessDTO.self)
            return response.toDomain()
        } catch{
            throw error
        }
    }
    
    func fetchPokemonEvolutionChain(for url: String) async throws -> EvolutionChain{
        let request = NetworkRequest(path: url, method: .get, fullURL: true)
        do{
            let response = try await networkManager.request(request: request ,responseType: EvolutionChainDTO.self)
            return response.toDomain()
        } catch{
            throw error
        }
    }
}
